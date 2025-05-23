import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrition/screens/home/home_screen.dart';
import 'package:nutrition/screens/meal_detail/meal_details.dart';
import 'package:nutrition/screens/food_selection/food_items.dart';
import 'package:nutrition/screens/food_selection/portion_selection.dart';
import 'package:nutrition/screens/food_selection/meal_timing.dart';
import 'package:nutrition/screens/food_selection/dietary_goals.dart';
import 'package:nutrition/screens/meal_planner/weekly_meal_planner_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes debug banner
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[100],
        textTheme: GoogleFonts.soraTextTheme(),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/mealDetail': (context) => const MealDetails(),
        '/foodSelection': (context) => const FoodList(),
        '/portionSelection': (context) =>
            const PortionSelection(selectedFoods: []),
        '/mealTiming': (context) => const MealTiming(),
        '/dietaryGoals': (context) => const DietaryGoals(),
        '/mealPlanner': (context) => const WeeklyMealPlannerScreen(),
      },
    );
  }
}
