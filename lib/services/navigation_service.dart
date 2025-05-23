import 'package:flutter/material.dart';

class NavigationService {
  static void startFoodSelection(BuildContext context) {
    Navigator.pushNamed(context, '/foodSelection');
  }

  static void goToPortionSelection(
      BuildContext context, List<String> selectedFoods) {
    Navigator.pushNamed(
      context,
      '/portionSelection',
      arguments: selectedFoods,
    );
  }

  static void goToMealTiming(BuildContext context) {
    Navigator.pushNamed(context, '/mealTiming');
  }

  static void goToDietaryGoals(BuildContext context) {
    Navigator.pushNamed(context, '/dietaryGoals');
  }

  static void completeFoodSelection(BuildContext context) {
    // Clear the entire navigation stack and go to home
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/',
      (route) => false,
    );
  }
}
