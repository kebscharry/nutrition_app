import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/meal_plan.dart';

class MealPlannerService {
  static const String _storageKey = 'meal_plans';

  // Save a meal plan
  Future<void> saveMealPlan(MealPlan mealPlan) async {
    final prefs = await SharedPreferences.getInstance();
    final storedPlans = await getMealPlans();

    // Remove any existing meal plan for the same date and meal type
    storedPlans.removeWhere((plan) =>
        plan.date.year == mealPlan.date.year &&
        plan.date.month == mealPlan.date.month &&
        plan.date.day == mealPlan.date.day &&
        plan.mealType == mealPlan.mealType);

    // Add new meal plan
    storedPlans.add(mealPlan);

    // Save updated list
    final jsonList = storedPlans.map((plan) => plan.toJson()).toList();
    await prefs.setString(_storageKey, jsonEncode(jsonList));
  }

  // Get all meal plans
  Future<List<MealPlan>> getMealPlans() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);
    if (jsonString == null) return [];

    final jsonList = jsonDecode(jsonString) as List;
    return jsonList.map((json) => MealPlan.fromJson(json)).toList();
  }

  // Get meal plans for a specific date
  Future<List<MealPlan>> getMealPlansForDate(DateTime date) async {
    final allPlans = await getMealPlans();
    return allPlans
        .where((plan) =>
            plan.date.year == date.year &&
            plan.date.month == date.month &&
            plan.date.day == date.day)
        .toList();
  }

  // Delete a meal plan
  Future<void> deleteMealPlan(String mealPlanId) async {
    final prefs = await SharedPreferences.getInstance();
    final storedPlans = await getMealPlans();

    storedPlans.removeWhere((plan) => plan.id == mealPlanId);

    final jsonList = storedPlans.map((plan) => plan.toJson()).toList();
    await prefs.setString(_storageKey, jsonEncode(jsonList));
  }
}
