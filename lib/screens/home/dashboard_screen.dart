import 'package:flutter/material.dart';
import '../../models/meal_plan.dart';
import '../../services/meal_planner_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _mealPlannerService = MealPlannerService();
  MealPlanSummary? _todaysSummary;
  List<MealPlan> _todaysMeals = [];

  @override
  void initState() {
    super.initState();
    _loadTodaysMeals();
  }

  Future<void> _loadTodaysMeals() async {
    final meals = await _mealPlannerService.getMealPlansForDate(DateTime.now());
    if (mounted) {
      setState(() {
        _todaysMeals = meals;
        _todaysSummary = MealPlan.calculateDailySummary(meals);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: RefreshIndicator(
        onRefresh: _loadTodaysMeals,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildDailySummaryCard(),
                  const SizedBox(height: 24),
                  _buildQuickActions(),
                  const SizedBox(height: 24),
                  _buildTodaysMeals(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
            Text(
              'Your daily nutrition overview',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.brown[50],
          child: Icon(
            Icons.person_outline,
            color: Colors.brown[900],
          ),
        ),
      ],
    );
  }

  Widget _buildDailySummaryCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.brown[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Today's Summary",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[900],
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNutritionStat(
                  '🔥',
                  'Calories',
                  _todaysSummary?.formattedCalories ?? '0 kcal',
                ),
                _buildNutritionStat(
                  '🥩',
                  'Protein',
                  _todaysSummary?.formattedProtein ?? '0g',
                ),
                _buildNutritionStat(
                  '🌾',
                  'Carbs',
                  _todaysSummary?.formattedCarbs ?? '0g',
                ),
                _buildNutritionStat(
                  '🥑',
                  'Fats',
                  _todaysSummary?.formattedFats ?? '0g',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionStat(String emoji, String label, String value) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.brown[900],
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.brown[900],
              ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                icon: Icons.calendar_month,
                label: 'Meal Planner',
                color: Colors.blue[50]!,
                iconColor: Colors.blue,
                onTap: () => Navigator.pushNamed(context, '/mealPlanner'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildActionCard(
                icon: Icons.water_drop,
                label: 'Track Water',
                color: Colors.teal[50]!,
                iconColor: Colors.teal,
                onTap: () {
                  // TODO: Implement water tracking
                  Navigator.pushNamed(context, '/waterTracking');
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                icon: Icons.restaurant_menu,
                label: 'Add Meal',
                color: Colors.orange[50]!,
                iconColor: Colors.orange,
                onTap: () => Navigator.pushNamed(context, '/foodSelection'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildActionCard(
                icon: Icons.insights,
                label: 'Statistics',
                color: Colors.purple[50]!,
                iconColor: Colors.purple,
                onTap: () {
                  // TODO: Implement statistics screen
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String label,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      color: color,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, size: 32, color: iconColor),
              const SizedBox(height: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTodaysMeals() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Today's Meals",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        if (_todaysMeals.isEmpty)
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text(
                  'No meals added for today',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),
          )
        else
          ...['Breakfast', 'Lunch', 'Dinner', 'Snacks'].map((mealType) {
            final meals = _todaysMeals
                .where((meal) => meal.mealType == mealType)
                .toList();
            if (meals.isEmpty) return const SizedBox.shrink();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    mealType,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                ...meals.map((meal) => _buildMealCard(meal)),
                const SizedBox(height: 8),
              ],
            );
          }),
      ],
    );
  }

  Widget _buildMealCard(MealPlan meal) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.brown[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.restaurant, color: Colors.brown),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.mealName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${meal.formattedCalories} • ${meal.formattedProtein} protein',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
