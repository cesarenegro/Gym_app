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
        return 'Pasto del Giorno';
      case DailyCategory.trainerTip:
        return 'Trainer Tip';
      case DailyCategory.challengeOfDay:
        return 'Sfida del Giorno';
    }
  }

  String get tagCode {
    switch (this) {
      case DailyCategory.workoutOfDay:
        return 'WOD';
      case DailyCategory.mealOfDay:
        return 'MEAL';
      case DailyCategory.trainerTip:
        return 'TIP';
      case DailyCategory.challengeOfDay:
        return 'CHALLENGE';
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
  });
}
