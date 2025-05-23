import 'package:flutter/material.dart';
import 'package:nutrition/screens/meal_detail/ingredient_list_section.dart';
import '../food_selection/food_items.dart';

class MealDetails extends StatelessWidget {
  const MealDetails({super.key});

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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FoodList()),
                );
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
                      const Text(
                        "Mix Salad\nVegetables",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildNutritionRow("240", "Calories", Colors.amber[50]),
                      const SizedBox(height: 5),
                      _buildNutritionRow("19gr", "Protein", Colors.blue[100]),
                      const SizedBox(height: 5),
                      _buildNutritionRow("5gr", "Carbs", Colors.green[50]),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // INGREDIENT LIST SECTION
            const Expanded(
              child: IngredientListSection(),
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
