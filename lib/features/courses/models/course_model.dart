class LessonStep {
  final String name;
  final int minutes;
  final String description;

  const LessonStep({
    required this.name,
    required this.minutes,
    required this.description,
  });
}

class CourseSession {
  final String id;
  final String courseId;
  final String courseName;
  final String category;
  final String trainerName;
  final String room;
  final DateTime startTime;
  final int durationMinutes;
  final int capacity;
  final int bookedCount;
  final String imageUrl;
  final String intensity;
  final String description;
  final List<String> objectives;
  final List<LessonStep> lessonStructure;
  final List<String> whatToBring;
  final String firstLesson;
  final String intensityNote;
  final List<String> relatedWorkoutIds;
  final bool isBookedByUser;
  final bool isWaitlistedByUser;

  const CourseSession({
    required this.id,
    required this.courseId,
    required this.courseName,
    required this.category,
    required this.trainerName,
    required this.room,
    required this.startTime,
    required this.durationMinutes,
    required this.capacity,
    required this.bookedCount,
    required this.imageUrl,
    required this.intensity,
    required this.description,
    this.objectives = const [],
    this.lessonStructure = const [],
    this.whatToBring = const [],
    this.firstLesson = '',
    this.intensityNote = '',
    this.relatedWorkoutIds = const [],
    this.isBookedByUser = false,
    this.isWaitlistedByUser = false,
  });

  int get spotsRemaining => (capacity - bookedCount).clamp(0, capacity);
  bool get isFull => bookedCount >= capacity;

  CourseSession copyWith({
    bool? isBookedByUser,
    bool? isWaitlistedByUser,
    int? bookedCount,
  }) {
    return CourseSession(
      id: id,
      courseId: courseId,
      courseName: courseName,
      category: category,
      trainerName: trainerName,
      room: room,
      startTime: startTime,
      durationMinutes: durationMinutes,
      capacity: capacity,
      bookedCount: bookedCount ?? this.bookedCount,
      imageUrl: imageUrl,
      intensity: intensity,
      description: description,
      objectives: objectives,
      lessonStructure: lessonStructure,
      whatToBring: whatToBring,
      firstLesson: firstLesson,
      intensityNote: intensityNote,
      relatedWorkoutIds: relatedWorkoutIds,
      isBookedByUser: isBookedByUser ?? this.isBookedByUser,
      isWaitlistedByUser: isWaitlistedByUser ?? this.isWaitlistedByUser,
    );
  }
}
