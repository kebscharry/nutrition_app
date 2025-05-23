import 'package:flutter/material.dart';
import 'package:nutrition/models/meal.dart';
import 'package:nutrition/models/meal_plan.dart';
import 'package:nutrition/screens/meal_detail/ingredient_list_section.dart';

class MealDetails extends StatelessWidget {
  final dynamic meal;

  const MealDetails({super.key, required this.meal});

  // Helper methods to handle both Meal and MealPlan types
  String get name => meal is Meal ? meal.name : meal.mealName;
  String get calories =>
      meal is Meal ? "${meal.calories}" : meal.formattedCalories;
  String get protein => meal is Meal ? meal.protein : meal.formattedProtein;
  String get carbs => meal is Meal ? meal.carbs : meal.formattedCarbs;
  List<Ingredient> get ingredients => meal is Meal
      ? meal.ingredients
      : (meal.ingredients as List<dynamic>)
          .map((i) => Ingredient(
                imagePath: "assets/food_plate.png",
                title: i.toString(),
                description: "Ingredient from meal plan",
              ))
          .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Container(
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.pink[50],
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4))
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -30,
                    bottom: -20,
                    child: Image.asset(
                      "assets/food_plate.png",
                      height: 320,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildNutritionRow(
                          calories, "Calories", Colors.amber[50]),
                      _buildNutritionRow(protein, "Protein", Colors.blue[100]),
                      _buildNutritionRow(carbs, "Carbs", Colors.green[50]),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: IngredientListSection(ingredients: ingredients),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionRow(String value, String label, Color? color) {
    return Row(
      children: [
        Container(
          height: 30,
          width: 5,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black87,
          ),
        ),
        Text(label),
      ],
    );
  }
}
