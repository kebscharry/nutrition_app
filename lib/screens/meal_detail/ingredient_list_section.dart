// ingredient_list_section.dart
import 'package:flutter/material.dart';
import 'ingredient_tile.dart';

class IngredientListSection extends StatelessWidget {
  const IngredientListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Ingredients",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView(
            children: const [
              IngredientTile(
                imagePath: "assets/shrimp.png",
                title: "Shrimp",
                description:
                    "The shrimp is briefly fried, then add instant sauce to it",
              ),
              IngredientTile(
                imagePath: "assets/strawberry.png",
                title: "Strawberry",
                description:
                    "To make your dish balanced include natural sugar from the fruit",
              ),
              IngredientTile(
                imagePath: "assets/kale.png",
                title: "Kale",
                description:
                    "Vegetables rich in nutrients that contain minerals and antioxidants",
              ),
              IngredientTile(
                imagePath: "assets/corn.png",
                title: "Corn",
                description:
                    "Corn is a healthy grain to add texture to your meals",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
