import 'package:flutter/material.dart';
import '../../../widgets/nutrition_summary_card.dart';
import '../../../widgets/meal_type_selector.dart';
import '../../../widgets/meal_preview_card.dart';
import 'dashboard_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String selectedMeal = 'Breakfast';
  final String userName = 'Kaluna'; // Can be fetched from user data

  final List<Map<String, dynamic>> nutritionData = [
    {
      'title': 'Kalori',
      'value': '832',
      'unit': 'KCal',
      'icon': Icons.local_fire_department_outlined,
      'color': Colors.white,
    },
    {
      'title': 'Protein',
      'value': '200',
      'unit': 'gr',
      'icon': Icons.fastfood_rounded,
      'color': Color(0xFFE0F2F1),
    },
    {
      'title': 'Water',
      'value': '1000',
      'unit': 'ml',
      'icon': Icons.water_drop_outlined,
      'color': Color(0xFFFCE4EC),
    },
    {
      'title': 'Carbs',
      'value': '820',
      'unit': 'KCal',
      'icon': Icons.food_bank_outlined,
      'color': Color(0xFFFFF9C4),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeContent(),
          const DashboardScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGreeting(),
              const SizedBox(height: 20),
              _buildNutritionSummary(),
              const SizedBox(height: 20),
              MealTypeSelector(
                selectedMeal: selectedMeal,
                onMealSelected: (meal) => setState(() => selectedMeal = meal),
              ),
              const SizedBox(height: 20),
              MealPreviewCard(
                title: "With mix vegetables",
                subtitle: "fresh and low calorie",
                imagePath: "assets/food.jpg",
                onTap: () {
                  // TODO: Navigate to meal detail screen
                  Navigator.pushNamed(context, '/mealDetail');
                },
              ),
              const SizedBox(height: 30),
              _buildMacronutrientStats(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      titleSpacing: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: const CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage("assets/avatar.jpg"),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.calendar_month),
          onPressed: () => Navigator.pushNamed(context, '/mealPlanner'),
          tooltip: 'Weekly Meal Planner',
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.1),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Badge(
              backgroundColor: Theme.of(context).colorScheme.error,
              smallSize: 5,
              child: Icon(Icons.notifications_none_outlined,
                  color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGreeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                  text: "Hello ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
              TextSpan(
                text: userName,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 3),
        const Text(
          "Complete your daily\nnutrition",
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildNutritionSummary() {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: nutritionData.length,
        itemBuilder: (context, index) {
          final item = nutritionData[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: NutritionSummaryCard(
              title: item['title'],
              value: item['value'],
              unit: item['unit'],
              icon: item['icon'],
              color: item['color'],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMacronutrientStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        _NutrientStat(title: "Calories", value: "290", unit: ""),
        _NutrientStat(title: "Protein", value: "16", unit: "gr"),
        _NutrientStat(title: "Carbs", value: "56", unit: "gr"),
      ],
    );
  }
}

class _NutrientStat extends StatelessWidget {
  final String title, value, unit;
  const _NutrientStat(
      {required this.title, required this.value, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "$value $unit",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(title),
        const SizedBox(height: 3),
        Container(
          width: 50,
          height: 10,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}
