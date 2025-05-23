// A class to hold daily nutrition totals
class MealPlanSummary {
  final int calories;
  final double protein;
  final double carbs;
  final double fats;

  const MealPlanSummary({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
  });

  // Format nutrition values for display
  String get formattedCalories => '$calories kcal';
  String get formattedProtein => '${protein.toStringAsFixed(1)}g';
  String get formattedCarbs => '${carbs.toStringAsFixed(1)}g';
  String get formattedFats => '${fats.toStringAsFixed(1)}g';
}

class MealPlan {
  final String id;
  final DateTime date;
  final String mealType; // Breakfast, Lunch, Dinner, Snacks
  final String mealName;
  final List<String> ingredients;
  final int calories;
  final double protein;
  final double carbs;
  final double fats;

  MealPlan({
    required this.id,
    required this.date,
    required this.mealType,
    required this.mealName,
    required this.ingredients,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
  })  : assert(calories >= 0),
        assert(protein >= 0),
        assert(carbs >= 0),
        assert(fats >= 0);

  // Calculate total nutrition for a list of meals
  static MealPlanSummary calculateDailySummary(List<MealPlan> meals) {
    int totalCalories = 0;
    double totalProtein = 0;
    double totalCarbs = 0;
    double totalFats = 0;

    for (final meal in meals) {
      totalCalories += meal.calories;
      totalProtein += meal.protein;
      totalCarbs += meal.carbs;
      totalFats += meal.fats;
    }

    return MealPlanSummary(
      calories: totalCalories,
      protein: totalProtein,
      carbs: totalCarbs,
      fats: totalFats,
    );
  }

  // Format nutrition values for display
  String get formattedCalories => '$calories kcal';
  String get formattedProtein => '${protein.toStringAsFixed(1)}g';
  String get formattedCarbs => '${carbs.toStringAsFixed(1)}g';
  String get formattedFats => '${fats.toStringAsFixed(1)}g';

  // Create a copy of this MealPlan with some fields replaced
  MealPlan copyWith({
    String? id,
    DateTime? date,
    String? mealType,
    String? mealName,
    List<String>? ingredients,
    int? calories,
    double? protein,
    double? carbs,
    double? fats,
  }) {
    return MealPlan(
      id: id ?? this.id,
      date: date ?? this.date,
      mealType: mealType ?? this.mealType,
      mealName: mealName ?? this.mealName,
      ingredients: ingredients ?? this.ingredients,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fats: fats ?? this.fats,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'mealType': mealType,
      'mealName': mealName,
      'ingredients': ingredients,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fats': fats,
    };
  }

  factory MealPlan.fromJson(Map<String, dynamic> json) {
    return MealPlan(
      id: json['id'],
      date: DateTime.parse(json['date']),
      mealType: json['mealType'],
      mealName: json['mealName'],
      ingredients: List<String>.from(json['ingredients']),
      calories: json['calories'],
      protein: json['protein'].toDouble(),
      carbs: json['carbs'].toDouble(),
      fats: json['fats'].toDouble(),
    );
  }
}
