// ingredient_list_section.dart
import 'package:flutter/material.dart';
import 'package:nutrition/models/meal.dart';
import 'ingredient_tile.dart';

class IngredientListSection extends StatelessWidget {
  final List<Ingredient> ingredients;
  const IngredientListSection({super.key, required this.ingredients});

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
            children: ingredients
                .map((ingredient) => IngredientTile(
                      imagePath: ingredient.imagePath,
                      title: ingredient.title,
                      description: ingredient.description,
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
