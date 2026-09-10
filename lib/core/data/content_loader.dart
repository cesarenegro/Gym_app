import 'dart:convert';
import 'package:flutter/services.dart';
import '../../features/dailies/models/daily_item.dart';
import '../../features/training/models/training_models.dart';
import '../../features/courses/models/course_model.dart';

class ContentLoader {
  static Future<List<DailyItem>> loadDailies() async {
    try {
      final jsonString = await rootBundle.loadString('assets/json/recipes.json');
      final data = json.decode(jsonString);
      final List items = data['items'] ?? [];
      final Map<String, dynamic> tagsMeta = data['tags'] ?? {};

      return items.map<DailyItem>((map) {
        final List<String> tagList = List<String>.from(map['tags'] ?? []);
        String? tagNote;

        for (final tag in tagList) {
          if (tagsMeta.containsKey(tag)) {
            final tagObj = tagsMeta[tag];
            if (tagObj['requires_visible_note'] == true) {
              tagNote = tagObj['meaning'];
              break;
            }
          }
        }

        final rawImg = map['image'] ?? '';
        final filename = rawImg.split('/').last;
        final assetImage = 'assets/images/dailies/$filename';

        return DailyItem(
          id: map['id'] ?? '',
          title: map['title'] ?? '',
          subtitle: map['card_text'] ?? '',
          category: DailyCategory.mealOfDay,
          durationOrMetric: map['total_time_label'] ?? '15 min',
          imageUrl: assetImage,
          author: 'KINETIC Chef & Nutritionist',
          description: map['card_text'] ?? '',
          bulletPoints: List<String>.from(map['ingredients'] ?? []).take(4).toList(),
          ctaLabel: 'Vedi Ricetta & Passaggi',
          ctaAction: 'view_recipe',
          publishedAt: DateTime.now(),
          mealType: map['meal_type'] ?? 'Pasto',
          servings: map['servings'] ?? 1,
          difficulty: map['difficulty'] ?? 'Facile',
          totalTimeLabel: map['total_time_label'] ?? '15 min',
          ingredients: List<String>.from(map['ingredients'] ?? []),
          steps: List<String>.from(map['steps'] ?? []),
          tags: tagList,
          tagNote: tagNote,
        );
      }).toList();
    } catch (e) {
      return fallbackDailies;
    }
  }

  static Future<List<WorkoutPlan>> loadWorkouts() async {
    try {
      final jsonString = await rootBundle.loadString('assets/json/workouts.json');
      final data = json.decode(jsonString);
      final List items = data['items'] ?? [];

      return items.map<WorkoutPlan>((map) {
        final rawImg = map['image'] ?? '';
        final filename = rawImg.split('/').last;
        final assetImage = 'assets/images/workouts/$filename';

        final warmup = map['warmup'] ?? {};
        final cooldown = map['cooldown'] ?? {};
        final List rawExercises = map['exercises'] ?? [];

        final exercises = rawExercises.map<WorkoutExercise>((exMap) {
          return WorkoutExercise(
            id: exMap['exercise_id'] ?? '',
            name: exMap['name'] ?? '',
            muscleGroup: exMap['dose'] ?? '',
            targetSetsReps: exMap['dose'] ?? '',
            previousBest: 'Record personalizzato',
            restSeconds: exMap['rest_after_seconds'] ?? 45,
            instructions: exMap['instructions'] ?? '',
            easierOption: exMap['easier_option'] ?? '',
            sets: List.generate(
              map['rounds'] ?? 3,
              (idx) => ExerciseSet(
                setNumber: idx + 1,
                targetWeightKg: 0.0,
                targetReps: 10,
              ),
            ),
          );
        }).toList();

        return WorkoutPlan(
          id: map['id'] ?? '',
          title: map['title'] ?? '',
          phase: 'LIVELLO · ${(map['level'] ?? 'BASE').toString().toUpperCase()}',
          splitName: map['card_text'] ?? '',
          durationMinutes: map['duration_minutes_approx'] ?? 30,
          coachName: 'Coach Kinetic',
          imageUrl: assetImage,
          intensityRpe: map['intensity_rpe'] ?? '6/10',
          format: map['format'] ?? 'Circuito controllato',
          rounds: map['rounds'] ?? 3,
          equipment: List<String>.from(map['equipment'] ?? []),
          warmupMinutes: warmup['minutes'] ?? 4,
          warmupInstructions: warmup['instructions'] ?? '',
          cooldownMinutes: cooldown['minutes'] ?? 3,
          cooldownInstructions: cooldown['instructions'] ?? '',
          betweenRoundsRestSeconds: map['between_rounds_rest_seconds'] ?? 60,
          exercises: exercises,
          scheduledDate: DateTime.now(),
        );
      }).toList();
    } catch (e) {
      return fallbackWorkouts;
    }
  }

  static Future<List<CourseSession>> loadCourses() async {
    try {
      final jsonString = await rootBundle.loadString('assets/json/courses.json');
      final data = json.decode(jsonString);
      final List items = data['items'] ?? [];

      return items.map<CourseSession>((map) {
        final rawImg = map['image'] ?? '';
        final filename = rawImg.split('/').last;
        final assetImage = 'assets/images/courses/$filename';

        final List rawStructure = map['lesson_structure'] ?? [];
        final lessonStructure = rawStructure.map<LessonStep>((s) {
          return LessonStep(
            name: s['name'] ?? '',
            minutes: s['minutes'] ?? 5,
            description: s['description'] ?? '',
          );
        }).toList();

        return CourseSession(
          id: map['id'] ?? '',
          courseId: map['id'] ?? '',
          courseName: map['title'] ?? '',
          category: map['level'] ?? 'Base',
          trainerName: 'Team Kinetic',
          room: 'Sala Studio Main',
          startTime: DateTime.now().add(const Duration(hours: 2)),
          durationMinutes: map['duration_minutes'] ?? 45,
          capacity: 14,
          bookedCount: 6,
          imageUrl: assetImage,
          intensity: 'Attivo',
          description: map['description'] ?? map['card_text'] ?? '',
          objectives: List<String>.from(map['objectives'] ?? []),
          lessonStructure: lessonStructure,
          whatToBring: List<String>.from(map['what_to_bring'] ?? []),
          firstLesson: map['first_lesson'] ?? '',
          intensityNote: map['intensity_note'] ?? '',
          relatedWorkoutIds: List<String>.from(map['related_workout_ids'] ?? []),
        );
      }).toList();
    } catch (e) {
      return fallbackCourses;
    }
  }

  static final List<DailyItem> fallbackDailies = [
    DailyItem(
      id: 'M01',
      title: 'Pancake cacao e lamponi',
      subtitle: 'Il lato goloso della tua colazione.',
      category: DailyCategory.mealOfDay,
      durationOrMetric: '15 min',
      imageUrl: 'assets/images/dailies/M01.png',
      author: 'KINETIC Nutrition',
      description: 'Il lato goloso della tua colazione con yogurt greco e cacao amaro.',
      bulletPoints: ['40 g farina di avena', '1 uovo medio', '100 g yogurt greco 0%', '70 g lamponi'],
      ctaLabel: 'Vedi Ricetta & Passaggi',
      ctaAction: 'view_recipe',
      publishedAt: DateTime.now(),
      mealType: 'Colazione',
      servings: 1,
      difficulty: 'Facile',
      totalTimeLabel: '15 min',
      ingredients: [
        '40 g farina di avena',
        '1 uovo medio',
        '100 g yogurt greco bianco 0%',
        '50 ml latte',
        '5 g cacao amaro',
        '2 g lievito per dolci',
        '70 g lamponi',
        '5 g cioccolato fondente',
        '2 g olio per la padella'
      ],
      steps: [
        'Mescola farina, cacao e lievito. Aggiungi uovo, latte e 30 g di yogurt: ottieni una pastella densa.',
        'Scalda una padella antiaderente con l olio distribuito con un pennello. Versa tre piccole porzioni.',
        'Cuoci a fuoco medio-basso circa 2–3 minuti per lato, finché il centro è cotto.',
        'Servi con lo yogurt rimasto, lamponi lavati e cioccolato a scaglie.'
      ],
      tags: ['PROTEIN', 'SLIM'],
    ),
  ];

  static final List<WorkoutPlan> fallbackWorkouts = [
    WorkoutPlan(
      id: 'W01',
      title: 'Forza total body',
      phase: 'LIVELLO · BASE',
      splitName: 'Quattro movimenti. Una base solida.',
      durationMinutes: 30,
      coachName: 'Coach Kinetic',
      imageUrl: 'assets/images/workouts/W01.png',
      intensityRpe: '5–6/10',
      format: 'Circuito controllato',
      rounds: 3,
      equipment: ['Kettlebell o manubrio', 'Panca stabile', 'Tappetino'],
      warmupMinutes: 4,
      warmupInstructions: 'Marcia facile e mobilità dolce.',
      cooldownMinutes: 3,
      cooldownInstructions: 'Respirazione profonda e allungamento.',
      betweenRoundsRestSeconds: 60,
      exercises: [
        WorkoutExercise(
          id: 'goblet',
          name: 'Goblet squat',
          muscleGroup: '8–10 ripetizioni',
          targetSetsReps: '8–10 ripetizioni',
          previousBest: '16 kg × 10',
          restSeconds: 45,
          instructions: 'Tieni un peso leggero vicino al petto. Scendi con controllo e risali espirando.',
          easierOption: 'Esegui senza peso verso una panca.',
          sets: [
            ExerciseSet(setNumber: 1, targetWeightKg: 16.0, targetReps: 10),
            ExerciseSet(setNumber: 2, targetWeightKg: 16.0, targetReps: 10),
            ExerciseSet(setNumber: 3, targetWeightKg: 18.0, targetReps: 8),
          ],
        ),
      ],
      scheduledDate: DateTime.now(),
    ),
  ];

  static final List<CourseSession> fallbackCourses = [
    CourseSession(
      id: 'C01',
      courseId: 'C01',
      courseName: 'Strength Foundations',
      category: 'Base',
      trainerName: 'Team Kinetic',
      room: 'Sala Studio Main',
      startTime: DateTime.now().add(const Duration(hours: 2)),
      durationMinutes: 45,
      capacity: 14,
      bookedCount: 6,
      imageUrl: 'assets/images/courses/C01.png',
      intensity: 'Base',
      description: 'Un corso guidato per familiarizzare con squat, movimento dell anca, spinte e tirate.',
      objectives: ['Imparare i movimenti fondamentali', 'Gestire un carico adatto', 'Costruire continuità'],
      lessonStructure: [
        const LessonStep(name: 'Preparazione', minutes: 8, description: 'Mobilità dolce e attivazione generale.'),
        const LessonStep(name: 'Tecnica', minutes: 10, description: 'Dimostrazione e prove di goblet squat.'),
        const LessonStep(name: 'Circuito guidato', minutes: 22, description: 'Squat, rematore e push-up inclinato.'),
        const LessonStep(name: 'Chiusura', minutes: 5, description: 'Camminata facile e riepilogo tecnico.'),
      ],
      whatToBring: ['Abbigliamento sportivo comodo', 'Acqua', 'Asciugamano'],
      firstLesson: 'Presentati qualche minuto prima e comunica all istruttore il tuo livello.',
      intensityNote: 'Il trainer adatta carichi e ritmo al gruppo.',
      relatedWorkoutIds: ['W01', 'W07', 'W16'],
    ),
  ];
}
