import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrition/screens/home/home_screen.dart';
import 'package:nutrition/screens/hydration/water_tracking_screen.dart';
import 'package:nutrition/screens/food_selection/food_items.dart';
import 'package:nutrition/screens/food_selection/portion_selection.dart';
import 'package:nutrition/screens/food_selection/meal_timing.dart';
import 'package:nutrition/screens/food_selection/dietary_goals.dart';
import 'package:nutrition/screens/meal_planner/weekly_meal_planner_screen.dart';
import 'package:nutrition/screens/statistics/statistics_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Based on iPhone X
      minTextAdapt: true,
      splitScreenMode: true, // Optional: good for tablets and foldables
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.grey[100],
            textTheme: GoogleFonts.soraTextTheme(),
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const HomeScreen(),
            '/foodSelection': (context) => const FoodList(),
            '/portionSelection': (context) =>
                const PortionSelection(selectedFoods: []),
            '/mealTiming': (context) => const MealTiming(),
            '/dietaryGoals': (context) => const DietaryGoals(),
            '/mealPlanner': (context) => const WeeklyMealPlannerScreen(),
            '/waterTracking': (context) => const WaterTrackingScreen(),
            '/statistics': (context) => const StatisticsScreen(),
          },
        );
      },
    );
  }
}
