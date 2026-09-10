enum DailyCategory {
  workoutOfDay,
  mealOfDay,
  trainerTip,
  challengeOfDay,
}

extension DailyCategoryExt on DailyCategory {
  String get label {
    switch (this) {
      case DailyCategory.workoutOfDay:
        return 'Scheda del Giorno';
      case DailyCategory.mealOfDay:
        return 'Pasto & Ricetta';
      case DailyCategory.trainerTip:
        return 'Consiglio del Coach';
      case DailyCategory.challengeOfDay:
        return 'Sfida Atleta';
    }
  }

  String get tagCode {
    switch (this) {
      case DailyCategory.workoutOfDay:
        return 'WOD';
      case DailyCategory.mealOfDay:
        return 'RICETTA';
      case DailyCategory.trainerTip:
        return 'TIP';
      case DailyCategory.challengeOfDay:
        return 'SFIDA';
    }
  }
}

class DailyItem {
  final String id;
  final String title;
  final String subtitle;
  final DailyCategory category;
  final String durationOrMetric;
  final String imageUrl;
  final String author;
  final String description;
  final List<String> bulletPoints;
  final String ctaLabel;
  final String ctaAction;
  final DateTime publishedAt;
  
  // Campi specifici del pacchetto Dailies / Ricette
  final String mealType;
  final int servings;
  final String difficulty;
  final String totalTimeLabel;
  final List<String> ingredients;
  final List<String> steps;
  final List<String> tags;
  final String? tagNote;

  const DailyItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.durationOrMetric,
    required this.imageUrl,
    required this.author,
    required this.description,
    required this.bulletPoints,
    required this.ctaLabel,
    required this.ctaAction,
    required this.publishedAt,
    this.mealType = 'Pasto',
    this.servings = 1,
    this.difficulty = 'Facile',
    this.totalTimeLabel = '15 min',
    this.ingredients = const [],
    this.steps = const [],
    this.tags = const [],
    this.tagNote,
  });
}
