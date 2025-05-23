import 'package:flutter/material.dart';

class MealTypeSelector extends StatelessWidget {
  final String selectedMeal;
  final Function(String) onMealSelected;

  const MealTypeSelector({
    super.key,
    required this.selectedMeal,
    required this.onMealSelected,
  });

  @override
  Widget build(BuildContext context) {
    final meals = ['Breakfast', 'Lunch', 'Dinner'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: meals.map((meal) {
        final isSelected = meal == selectedMeal;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isSelected ? Colors.black : Colors.white,
                foregroundColor: isSelected ? Colors.white : Colors.black,
                side: isSelected
                    ? BorderSide.none
                    : const BorderSide(color: Colors.black12),
                elevation: isSelected ? 2 : 0,
              ),
              onPressed: () => onMealSelected(meal),
              child: Text(meal),
            ),
          ),
        );
      }).toList(),
    );
  }
}
