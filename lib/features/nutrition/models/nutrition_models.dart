enum MealType { breakfast, lunch, snack, dinner }

enum PlanSource { professionalAssigned, aiSuggested }

class MealEntry {
  final String id;
  final String title;
  final MealType type;
  final int calories;
  final int proteinG;
  final int carbsG;
  final int fatG;
  final List<String> foods;
  final bool isCompleted;
  final PlanSource source;

  const MealEntry({
    required this.id,
    required this.title,
    required this.type,
    required this.calories,
    required this.proteinG,
    required this.carbsG,
    required this.fatG,
    required this.foods,
    this.isCompleted = false,
    this.source = PlanSource.professionalAssigned,
  });
}

class DailyNutritionSummary {
  final int targetCalories;
  final int consumedCalories;
  final int targetProteinG;
  final int consumedProteinG;
  final int targetCarbsG;
  final int consumedCarbsG;
  final int targetFatG;
  final int consumedFatG;
  final List<MealEntry> meals;

  const DailyNutritionSummary({
    required this.targetCalories,
    required this.consumedCalories,
    required this.targetProteinG,
    required this.consumedProteinG,
    required this.targetCarbsG,
    required this.consumedCarbsG,
    required this.targetFatG,
    required this.consumedFatG,
    required this.meals,
  });
}
