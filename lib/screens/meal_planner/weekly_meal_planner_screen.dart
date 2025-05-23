import 'package:flutter/material.dart';
import 'package:nutrition/screens/meal_detail/meal_details.dart';
import '../../models/meal_plan.dart';
import '../../services/meal_planner_service.dart';
import 'add_meal_dialog.dart';

class WeeklyMealPlannerScreen extends StatefulWidget {
  const WeeklyMealPlannerScreen({super.key});

  @override
  State<WeeklyMealPlannerScreen> createState() =>
      _WeeklyMealPlannerScreenState();
}

class _WeeklyMealPlannerScreenState extends State<WeeklyMealPlannerScreen> {
  late DateTime _selectedDate;
  late List<DateTime> _weekDates;
  int _selectedDayIndex = 0;
  final _mealPlannerService = MealPlannerService();
  Map<String, List<MealPlan>> _mealsByType = {};

  final List<String> _mealTypes = ['Breakfast', 'Lunch', 'Dinner', 'Snacks'];
  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _generateWeekDates();
    _loadMealsForSelectedDate();
  }

  Future<void> _loadMealsForSelectedDate() async {
    final meals = await _mealPlannerService.getMealPlansForDate(_selectedDate);
    setState(() {
      _mealsByType = {};
      for (final meal in meals) {
        _mealsByType[meal.mealType] = _mealsByType[meal.mealType] ?? [];
        _mealsByType[meal.mealType]!.add(meal);
      }
    });
  }

  void _generateWeekDates() {
    // Get the date of Monday of current week
    DateTime monday = _selectedDate.subtract(
      Duration(days: _selectedDate.weekday - 1),
    );

    _weekDates = List.generate(
      7,
      (index) => monday.add(Duration(days: index)),
    );
  }

  String _getDayName(DateTime date) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }

  Future<void> _showAddMealDialog(String mealType) async {
    final meal = await showDialog<MealPlan>(
      context: context,
      builder: (context) => AddMealDialog(
        selectedDate: _selectedDate,
        mealType: mealType,
      ),
    );

    if (meal != null) {
      await _mealPlannerService.saveMealPlan(meal);
      _loadMealsForSelectedDate();
    }
  }

  Future<void> _deleteMeal(MealPlan meal) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Meal'),
        content: Text('Are you sure you want to delete "${meal.mealName}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed ?? false) {
      await _mealPlannerService.deleteMealPlan(meal.id);
      _loadMealsForSelectedDate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Meal Planner',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month, color: Colors.black),
            onPressed: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime(2024),
                lastDate: DateTime(2026),
              );
              if (picked != null) {
                setState(() {
                  _selectedDate = picked;
                  _generateWeekDates();
                });
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Week selector
          Container(
            height: 100,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (context, index) {
                final date = _weekDates[index];
                final isSelected = index == _selectedDayIndex;
                final isToday = date.year == DateTime.now().year &&
                    date.month == DateTime.now().month &&
                    date.day == DateTime.now().day;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDayIndex = index;
                      _selectedDate = date;
                    });
                    _loadMealsForSelectedDate();
                  },
                  child: Container(
                    width: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.brown[100] : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: isToday
                          ? Border.all(color: Colors.brown, width: 2)
                          : null,
                      boxShadow: [
                        if (isSelected)
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _getDayName(date),
                          style: TextStyle(
                            color: isSelected
                                ? Colors.brown[900]
                                : Colors.grey[600],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          date.day.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            color: isSelected
                                ? Colors.brown[900]
                                : Colors.grey[600],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Meal type sections
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _mealTypes.length,
              itemBuilder: (context, index) {
                final mealType = _mealTypes[index];
                return _buildMealTypeCard(mealType);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        child: const Icon(Icons.add),
        onPressed: () => _showAddMealDialog(_mealTypes[0]),
      ),
    );
  }

  Widget _buildMealTypeCard(String mealType) {
    final meals = _mealsByType[mealType] ?? [];

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  mealType,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () => _showAddMealDialog(mealType),
                ),
              ],
            ),
            const Divider(),
            if (meals.isEmpty)
              _buildEmptyState()
            else
              ...meals.map((meal) => _buildMealItem(meal)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.restaurant_menu,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'No meals added',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Tap + to add a meal to your plan',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealItem(MealPlan meal) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MealDetails(meal: meal),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.brown[50],
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(
                Icons.restaurant,
                color: Colors.brown,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.mealName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (meal.ingredients.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      meal.ingredients.join(', '),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _buildNutritionChip(
                        '🔥 ${meal.formattedCalories}',
                        Colors.orange[50]!,
                      ),
                      const SizedBox(width: 8),
                      _buildNutritionChip(
                        '🥩 ${meal.formattedProtein}',
                        Colors.red[50]!,
                      ),
                      const SizedBox(width: 8),
                      _buildNutritionChip(
                        '🌾 ${meal.formattedCarbs}',
                        Colors.green[50]!,
                      ),
                      const SizedBox(width: 8),
                      _buildNutritionChip(
                        '🥑 ${meal.formattedFats}',
                        Colors.yellow[50]!,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _deleteMeal(meal),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
