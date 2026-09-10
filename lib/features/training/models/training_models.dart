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
  final List<ExerciseSet> sets;

  WorkoutExercise({
    required this.id,
    required this.name,
    required this.muscleGroup,
    required this.targetSetsReps,
    required this.previousBest,
    required this.restSeconds,
    this.notes = '',
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
    required this.exercises,
    required this.scheduledDate,
    this.isCompleted = false,
  });
}
