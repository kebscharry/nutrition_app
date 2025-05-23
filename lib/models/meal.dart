// models/meal.dart
class Meal {
  final String name;
  final String imagePath;
  final int calories;
  final String protein;
  final String carbs;
  final List<Ingredient> ingredients;

  Meal({
    required this.name,
    required this.imagePath,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.ingredients,
  });
}

class Ingredient {
  final String imagePath;
  final String title;
  final String description;

  Ingredient({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}
