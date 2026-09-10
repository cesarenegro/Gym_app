class ExerciseSet {
  final int setNumber;
  final double targetWeightKg;
  final int targetReps;
  double? completedWeightKg;
  int? completedReps;
  bool isCompleted;

  ExerciseSet({
    required this.setNumber,
    required this.targetWeightKg,
    required this.targetReps,
    this.completedWeightKg,
    this.completedReps,
    this.isCompleted = false,
  });
}

class WorkoutExercise {
  final String id;
  final String name;
  final String muscleGroup;
  final String targetSetsReps;
  final String previousBest;
  final int restSeconds;
  final String notes;
  final String instructions;
  final String easierOption;
  final List<ExerciseSet> sets;

  WorkoutExercise({
    required this.id,
    required this.name,
    required this.muscleGroup,
    required this.targetSetsReps,
    required this.previousBest,
    required this.restSeconds,
    this.notes = '',
    this.instructions = '',
    this.easierOption = '',
    required this.sets,
  });
}

class WorkoutPlan {
  final String id;
  final String title;
  final String phase;
  final String splitName;
  final int durationMinutes;
  final String coachName;
  final String imageUrl;
  final String intensityRpe;
  final String format;
  final int rounds;
  final List<String> equipment;
  final int warmupMinutes;
  final String warmupInstructions;
  final int cooldownMinutes;
  final String cooldownInstructions;
  final int betweenRoundsRestSeconds;
  final List<WorkoutExercise> exercises;
  final DateTime scheduledDate;
  final bool isCompleted;

  const WorkoutPlan({
    required this.id,
    required this.title,
    required this.phase,
    required this.splitName,
    required this.durationMinutes,
    required this.coachName,
    this.imageUrl = '',
    this.intensityRpe = '6-7/10',
    this.format = 'Circuito guidato',
    this.rounds = 3,
    this.equipment = const [],
    this.warmupMinutes = 4,
    this.warmupInstructions = 'Attivazione e mobilità generale.',
    this.cooldownMinutes = 3,
    this.cooldownInstructions = 'Defaticamento e respirazione controllata.',
    this.betweenRoundsRestSeconds = 60,
    required this.exercises,
    required this.scheduledDate,
    this.isCompleted = false,
  });
}
