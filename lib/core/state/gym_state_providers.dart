import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../features/dailies/data/dailies_library.dart';
import '../../features/dailies/models/daily_item.dart';
import '../../features/courses/models/course_model.dart';
import '../../features/training/models/training_models.dart';
import '../../features/nutrition/models/nutrition_models.dart';
import '../../features/community/models/community_models.dart';
import '../../features/marketplace/models/product_model.dart';

// --- DAILIES PROVIDER ---
final dailiesProvider = Provider<List<DailyItem>>((ref) {
  return DailiesLibrary.preloadedDailies;
});

// --- COURSES NOTIFIER ---
class CoursesNotifier extends StateNotifier<List<CourseSession>> {
  CoursesNotifier() : super(_initialCourses);

  static final List<CourseSession> _initialCourses = [
    CourseSession(
      id: 'sess_1',
      courseId: 'c_mobility',
      courseName: 'Mobility & Joint Flow',
      category: 'Mobilità',
      trainerName: 'Sara V.',
      room: 'Sala Studio 1',
      startTime: DateTime.now().add(const Duration(hours: 2)),
      durationMinutes: 45,
      capacity: 14,
      bookedCount: 8,
      imageUrl: 'https://images.unsplash.com/photo-1518611012118-696072aa579a?q=80&w=800&auto=format&fit=crop',
      intensity: 'Bassa / Recupero',
      description: 'Sessione di scarico articolare, flessibilità fasciale e decompressione della colonna.',
    ),
    CourseSession(
      id: 'sess_2',
      courseId: 'c_functional',
      courseName: 'Functional Training Black',
      category: 'Funzionale',
      trainerName: 'Coach Andrea',
      room: 'Arena Centrale',
      startTime: DateTime.now().add(const Duration(hours: 4)),
      durationMinutes: 50,
      capacity: 16,
      bookedCount: 15,
      imageUrl: 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?q=80&w=800&auto=format&fit=crop',
      intensity: 'Alta',
      description: 'Lavoro ad alta potenza su circuiti metabolici, kettlebell, trazioni e slitte.',
    ),
    CourseSession(
      id: 'sess_3',
      courseId: 'c_boxing',
      courseName: 'Boxing Conditioning',
      category: 'Combat',
      trainerName: 'Marco R.',
      room: 'Ring & Bag Zone',
      startTime: DateTime.now().add(const Duration(hours: 6)),
      durationMinutes: 55,
      capacity: 12,
      bookedCount: 12, // Sold out for waitlist testing
      imageUrl: 'https://images.unsplash.com/photo-1549719386-74dfcbf7dbed?q=80&w=800&auto=format&fit=crop',
      intensity: 'Estrema',
      description: 'Tecniche di striking su sacco pesante, footwork e condizionamento lattacido.',
    ),
    CourseSession(
      id: 'sess_4',
      courseId: 'c_pilates',
      courseName: 'Reformer Pilates Dynamic',
      category: 'Postura',
      trainerName: 'Elena B.',
      room: 'Studio Reformer',
      startTime: DateTime.now().add(const Duration(days: 1, hours: 10)),
      durationMinutes: 50,
      capacity: 8,
      bookedCount: 4,
      imageUrl: 'https://images.unsplash.com/photo-1518611012118-696072aa579a?q=80&w=800&auto=format&fit=crop',
      intensity: 'Media',
      description: 'Controllo motorio e rinforzo del core profondo con macchinario Reformer.',
    ),
  ];

  bool bookSession(String sessionId) {
    state = state.map((s) {
      if (s.id == sessionId) {
        if (s.isFull && !s.isBookedByUser) {
          return s.copyWith(isWaitlistedByUser: true);
        } else if (!s.isBookedByUser) {
          return s.copyWith(
            isBookedByUser: true,
            bookedCount: s.bookedCount + 1,
          );
        } else {
          return s.copyWith(
            isBookedByUser: false,
            bookedCount: s.bookedCount > 0 ? s.bookedCount - 1 : 0,
          );
        }
      }
      return s;
    }).toList();
    return true;
  }

  void cancelWaitlist(String sessionId) {
    state = state.map((s) {
      if (s.id == sessionId) {
        return s.copyWith(isWaitlistedByUser: false);
      }
      return s;
    }).toList();
  }
}

final coursesProvider = StateNotifierProvider<CoursesNotifier, List<CourseSession>>((ref) {
  return CoursesNotifier();
});

// --- TRAINING NOTIFIER ---
class TrainingNotifier extends StateNotifier<WorkoutPlan> {
  TrainingNotifier() : super(_initialPlan);

  static final WorkoutPlan _initialPlan = WorkoutPlan(
    id: 'wp_today',
    title: 'FORZA PARTE SUPERIORE',
    phase: 'FASE II · IPERTROFIA',
    splitName: 'Spinte & Trazioni Orizzontali',
    durationMinutes: 48,
    coachName: 'Coach Andrea',
    scheduledDate: DateTime.now(),
    exercises: [
      WorkoutExercise(
        id: 'ex_1',
        name: 'Panca Piana con Bilanciere',
        muscleGroup: 'Pettorali & Tricipiti',
        targetSetsReps: '4 × 8 @ RPE 8.5',
        previousBest: '70 kg × 8',
        restSeconds: 120,
        notes: 'Arco lombare compatto, fermo al petto di 1 secondo.',
        sets: [
          ExerciseSet(setNumber: 1, targetWeightKg: 70.0, targetReps: 8),
          ExerciseSet(setNumber: 2, targetWeightKg: 72.5, targetReps: 8),
          ExerciseSet(setNumber: 3, targetWeightKg: 72.5, targetReps: 8),
          ExerciseSet(setNumber: 4, targetWeightKg: 75.0, targetReps: 6),
        ],
      ),
      WorkoutExercise(
        id: 'ex_2',
        name: 'Rematore con Manubrio su Panca',
        muscleGroup: 'Gran Dorsale',
        targetSetsReps: '4 × 10',
        previousBest: '32 kg × 10',
        restSeconds: 90,
        notes: 'Guida con il gomito verso l anca, nessun compenso con la schiena.',
        sets: [
          ExerciseSet(setNumber: 1, targetWeightKg: 30.0, targetReps: 10),
          ExerciseSet(setNumber: 2, targetWeightKg: 32.0, targetReps: 10),
          ExerciseSet(setNumber: 3, targetWeightKg: 32.0, targetReps: 10),
          ExerciseSet(setNumber: 4, targetWeightKg: 34.0, targetReps: 8),
        ],
      ),
      WorkoutExercise(
        id: 'ex_3',
        name: 'Military Press in Piedi',
        muscleGroup: 'Deltoidi Anteriori & Core',
        targetSetsReps: '3 × 8',
        previousBest: '45 kg × 8',
        restSeconds: 90,
        notes: 'Glutei e addome serrati per evitare iperestensione lombare.',
        sets: [
          ExerciseSet(setNumber: 1, targetWeightKg: 42.5, targetReps: 8),
          ExerciseSet(setNumber: 2, targetWeightKg: 45.0, targetReps: 8),
          ExerciseSet(setNumber: 3, targetWeightKg: 45.0, targetReps: 8),
        ],
      ),
      WorkoutExercise(
        id: 'ex_4',
        name: 'Dip alle Parallele Zavorrate',
        muscleGroup: 'Tricipiti & Basso Petto',
        targetSetsReps: '3 × 10',
        previousBest: '+10 kg × 10',
        restSeconds: 75,
        notes: 'Busto leggermente inclinato in avanti, discesa controllata.',
        sets: [
          ExerciseSet(setNumber: 1, targetWeightKg: 0.0, targetReps: 10),
          ExerciseSet(setNumber: 2, targetWeightKg: 10.0, targetReps: 10),
          ExerciseSet(setNumber: 3, targetWeightKg: 10.0, targetReps: 8),
        ],
      ),
    ],
  );

  void toggleSetComplete(String exerciseId, int setIndex) {
    state = WorkoutPlan(
      id: state.id,
      title: state.title,
      phase: state.phase,
      splitName: state.splitName,
      durationMinutes: state.durationMinutes,
      coachName: state.coachName,
      scheduledDate: state.scheduledDate,
      isCompleted: state.isCompleted,
      exercises: state.exercises.map((ex) {
        if (ex.id == exerciseId) {
          final updatedSets = List<ExerciseSet>.from(ex.sets);
          final s = updatedSets[setIndex];
          s.isCompleted = !s.isCompleted;
          if (s.isCompleted) {
            s.completedReps = s.targetReps;
            s.completedWeightKg = s.targetWeightKg;
          }
          return WorkoutExercise(
            id: ex.id,
            name: ex.name,
            muscleGroup: ex.muscleGroup,
            targetSetsReps: ex.targetSetsReps,
            previousBest: ex.previousBest,
            restSeconds: ex.restSeconds,
            notes: ex.notes,
            sets: updatedSets,
          );
        }
        return ex;
      }).toList(),
    );
  }
}

final trainingProvider = StateNotifierProvider<TrainingNotifier, WorkoutPlan>((ref) {
  return TrainingNotifier();
});

// --- NUTRITION PROVIDER ---
final nutritionProvider = Provider<DailyNutritionSummary>((ref) {
  return const DailyNutritionSummary(
    targetCalories: 2250,
    consumedCalories: 1870,
    targetProteinG: 160,
    consumedProteinG: 132,
    targetCarbsG: 240,
    consumedCarbsG: 180,
    targetFatG: 70,
    consumedFatG: 54,
    meals: [
      MealEntry(
        id: 'm_1',
        title: 'Colazione Energetica',
        type: MealType.breakfast,
        calories: 520,
        proteinG: 42,
        carbsG: 65,
        fatG: 12,
        foods: ['Porridge di avena (80g)', 'Albume pastorizzato (150g)', 'Frutti di bosco (50g)', 'Burro di arachidi 100% (15g)'],
        isCompleted: true,
        source: PlanSource.professionalAssigned,
      ),
      MealEntry(
        id: 'm_2',
        title: 'Pranzo Post-Workout',
        type: MealType.lunch,
        calories: 780,
        proteinG: 56,
        carbsG: 85,
        fatG: 22,
        foods: ['Riso Basmati (100g)', 'Petto di pollo alla piastra (220g)', 'Zucchine e peperoni grigliati', 'Olio Extravergine (15g)'],
        isCompleted: true,
        source: PlanSource.professionalAssigned,
      ),
      MealEntry(
        id: 'm_3',
        title: 'Spuntino Pomeridiano',
        type: MealType.snack,
        calories: 280,
        proteinG: 25,
        carbsG: 20,
        fatG: 10,
        foods: ['Yogurt Greco 0% (200g)', 'Noci dell Amazzonia (15g)', 'Cannella'],
        isCompleted: true,
        source: PlanSource.aiSuggested,
      ),
      MealEntry(
        id: 'm_4',
        title: 'Cena Ripristino Muscolare',
        type: MealType.dinner,
        calories: 670,
        proteinG: 37,
        carbsG: 70,
        fatG: 26,
        foods: ['Filetto di orata al forno (250g)', 'Patate al vapore (250g)', 'Insalata mista con pomodori'],
        isCompleted: false,
        source: PlanSource.professionalAssigned,
      ),
    ],
  );
});

// --- COMMUNITY NOTIFIER ---
class CommunityNotifier extends StateNotifier<List<CommunityPost>> {
  CommunityNotifier() : super(_initialPosts);

  static final List<CommunityPost> _initialPosts = [
    CommunityPost(
      id: 'p_1',
      authorName: 'Coach Andrea',
      authorAvatar: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=200&auto=format&fit=crop',
      authorRole: 'Head Coach',
      content: 'Nuovo record stabilito ieri sera nella sessione Black Functional! 300 round complessivi chiusi dal gruppo delle 19:30. Ricordate: la costanza batte sempre l intensità occasionale.',
      imageUrl: 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?q=80&w=800&auto=format&fit=crop',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      likesCount: 28,
      commentsCount: 6,
      isLikedByMe: true,
      type: PostType.trainerTip,
    ),
    CommunityPost(
      id: 'p_2',
      authorName: 'Marco Rossi',
      authorAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=200&auto=format&fit=crop',
      authorRole: 'Membro Black',
      content: 'Dopo 4 mesi di Fase II Ipertrofia, finalmente 140kg di stacco da terra puliti senza compensi. Grazie ai consigli di setup di @Coach Andrea!',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      likesCount: 42,
      commentsCount: 9,
      type: PostType.achievement,
    ),
  ];

  void toggleLike(String postId) {
    state = state.map((p) {
      if (p.id == postId) {
        final newLiked = !p.isLikedByMe;
        return p.copyWith(
          isLikedByMe: newLiked,
          likesCount: newLiked ? p.likesCount + 1 : (p.likesCount > 0 ? p.likesCount - 1 : 0),
        );
      }
      return p;
    }).toList();
  }

  void reportPost(String postId, String reason) {
    state = state.map((p) {
      if (p.id == postId) {
        return p.copyWith(moderationStatus: ModerationStatus.reported);
      }
      return p;
    }).toList();
  }

  void hidePost(String postId) {
    state = state.where((p) => p.id != postId).toList();
  }
}

final communityProvider = StateNotifierProvider<CommunityNotifier, List<CommunityPost>>((ref) {
  return CommunityNotifier();
});

// --- MARKETPLACE PROVIDER ---
final marketplaceProvider = Provider<List<MarketplaceProduct>>((ref) {
  return const [
    MarketplaceProduct(
      id: 'prod_1',
      title: 'Nike Metcon 9 Black Edition',
      category: 'Calzature',
      priceEur: 85.0,
      sellerName: 'Marco Rossi',
      sellerType: SellerType.member,
      imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=800&auto=format&fit=crop',
      description: 'Scarpe da training e crossfit utilizzate solo per 3 sessioni su parquet. Condizioni pari al nuovo con soletta igienizzata.',
      condition: 'Pari al Nuovo (Usato 3 volte)',
      sizeOrVariant: 'Taglia EU 43',
    ),
    MarketplaceProduct(
      id: 'prod_2',
      title: 'KINETIC Official Performance Hoodie',
      category: 'Abbigliamento Ufficiale',
      priceEur: 69.0,
      sellerName: 'KINETIC Club',
      sellerType: SellerType.gymOfficial,
      imageUrl: 'https://images.unsplash.com/photo-1556905055-8f358a7a47b2?q=80&w=800&auto=format&fit=crop',
      description: 'Felpa tecnica ad alta traspirabilità con cappuccio ergonomico, tasca termosaldata e logo serigrafato Volt.',
      condition: 'Nuovo da Magazzino Club',
      sizeOrVariant: 'Taglie disponibili: S, M, L, XL',
    ),
    MarketplaceProduct(
      id: 'prod_3',
      title: 'Cintura Sollevamento Cuoio 10mm',
      category: 'Attrezzatura',
      priceEur: 45.0,
      sellerName: 'Davide B.',
      sellerType: SellerType.member,
      imageUrl: 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?q=80&w=800&auto=format&fit=crop',
      description: 'Cintura da powerlifting in cuoio naturale rigido con fibbia a leva d acciaio inossidabile.',
      condition: 'Ottimo stato',
      sizeOrVariant: 'Taglia M (Girovita 75-90cm)',
    ),
  ];
});
