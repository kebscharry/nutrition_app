import 'package:flutter/material.dart';
import '../../models/meal_plan.dart';
import '../../services/meal_planner_service.dart';
import '../../services/water_tracking_service.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen>
    with SingleTickerProviderStateMixin {
  final _mealPlannerService = MealPlannerService();
  final _waterTrackingService = WaterTrackingService();
  late TabController _tabController;
  List<MealPlan> _weeklyMeals = [];
  double _weeklyWater = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadWeeklyData();
  }

  Future<void> _loadWeeklyData() async {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    List<MealPlan> weeklyMeals = [];
    for (var date = startOfWeek;
        date.isBefore(endOfWeek.add(const Duration(days: 1)));
        date = date.add(const Duration(days: 1))) {
      final meals = await _mealPlannerService.getMealPlansForDate(date);
      weeklyMeals.addAll(meals);
    }

    // ✅ Use getWaterIntakeForDate instead of undefined getTodaysTotalWater
    final todayWater =
        await _waterTrackingService.getWaterIntakeForDate(DateTime.now());

    if (mounted) {
      setState(() {
        _weeklyMeals = weeklyMeals;
        _weeklyWater = todayWater.toDouble();
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Statistics',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.purple,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.purple,
          tabs: const [
            Tab(text: 'Nutrition'),
            Tab(text: 'Water'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNutritionStats(),
          _buildWaterStats(),
        ],
      ),
    );
  }

  Widget _buildNutritionStats() {
    final summary = MealPlan.calculateDailySummary(_weeklyMeals);
    final averageCalories = summary.calories / 7;
    final averageProtein = summary.protein / 7;
    final averageCarbs = summary.carbs / 7;
    final averageFats = summary.fats / 7;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatCard(
            'Weekly Average',
            [
              _buildStatItem(
                  'Calories', averageCalories.round(), 'kcal', Colors.orange),
              _buildStatItem(
                  'Protein', averageProtein.round(), 'g', Colors.red),
              _buildStatItem('Carbs', averageCarbs.round(), 'g', Colors.green),
              _buildStatItem('Fats', averageFats.round(), 'g', Colors.yellow),
            ],
          ),
          const SizedBox(height: 16),
          _buildStatCard(
            'Total This Week',
            [
              _buildStatItem(
                  'Calories', summary.calories.round(), 'kcal', Colors.orange),
              _buildStatItem(
                  'Protein', summary.protein.round(), 'g', Colors.red),
              _buildStatItem('Carbs', summary.carbs.round(), 'g', Colors.green),
              _buildStatItem('Fats', summary.fats.round(), 'g', Colors.yellow),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWaterStats() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatCard(
            'Water Intake',
            [
              _buildStatItem(
                  "Today's Total", _weeklyWater.round(), 'ml', Colors.blue),
              _buildStatItem('Daily Goal', 2000, 'ml', Colors.blue),
            ],
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'Weekly water tracking coming soon!',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, List<Widget> stats) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: stats,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, num value, String unit, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            '$value $unit',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color.withOpacity(0.8),
                ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.black87,
                ),
          ),
        ],
      ),
    );
  }
}
