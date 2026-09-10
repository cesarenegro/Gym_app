import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../data/content_loader.dart';
import '../../features/dailies/models/daily_item.dart';
import '../../features/courses/models/course_model.dart';
import '../../features/training/models/training_models.dart';
import '../../features/nutrition/models/nutrition_models.dart';
import '../../features/community/models/community_models.dart';
import '../../features/marketplace/models/product_model.dart';

// --- DAILIES NOTIFIER ---
class DailiesNotifier extends StateNotifier<List<DailyItem>> {
  DailiesNotifier() : super(ContentLoader.fallbackDailies) {
    _init();
  }

  Future<void> _init() async {
    final items = await ContentLoader.loadDailies();
    if (items.isNotEmpty) {
      state = items;
    }
  }
}

final dailiesProvider = StateNotifierProvider<DailiesNotifier, List<DailyItem>>((ref) {
  return DailiesNotifier();
});

// --- COURSES NOTIFIER ---
class CoursesNotifier extends StateNotifier<List<CourseSession>> {
  CoursesNotifier() : super(ContentLoader.fallbackCourses) {
    _init();
  }

  Future<void> _init() async {
    final items = await ContentLoader.loadCourses();
    if (items.isNotEmpty) {
      state = items;
    }
  }

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

// --- WORKOUTS LIST PROVIDER ---
class WorkoutsNotifier extends StateNotifier<List<WorkoutPlan>> {
  WorkoutsNotifier() : super(ContentLoader.fallbackWorkouts) {
    _init();
  }

  Future<void> _init() async {
    final items = await ContentLoader.loadWorkouts();
    if (items.isNotEmpty) {
      state = items;
    }
  }
}

final workoutsListProvider = StateNotifierProvider<WorkoutsNotifier, List<WorkoutPlan>>((ref) {
  return WorkoutsNotifier();
});

// --- TRAINING NOTIFIER (Active Selected Workout) ---
class TrainingNotifier extends StateNotifier<WorkoutPlan> {
  TrainingNotifier() : super(ContentLoader.fallbackWorkouts.first) {
    _init();
  }

  Future<void> _init() async {
    final items = await ContentLoader.loadWorkouts();
    if (items.isNotEmpty) {
      state = items.first;
    }
  }

  void selectWorkout(WorkoutPlan plan) {
    state = plan;
  }

  void toggleSetComplete(String exerciseId, int setIndex) {
    state = WorkoutPlan(
      id: state.id,
      title: state.title,
      phase: state.phase,
      splitName: state.splitName,
      durationMinutes: state.durationMinutes,
      coachName: state.coachName,
      imageUrl: state.imageUrl,
      intensityRpe: state.intensityRpe,
      format: state.format,
      rounds: state.rounds,
      equipment: state.equipment,
      warmupMinutes: state.warmupMinutes,
      warmupInstructions: state.warmupInstructions,
      cooldownMinutes: state.cooldownMinutes,
      cooldownInstructions: state.cooldownInstructions,
      betweenRoundsRestSeconds: state.betweenRoundsRestSeconds,
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
            instructions: ex.instructions,
            easierOption: ex.easierOption,
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
        foods: ['Pancake cacao e lamponi (M01)', 'Yogurt Greco 0% (100g)', 'Cacao amaro e lamponi freschi'],
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
        foods: ['Riso Basmati e pollo al vapore', 'Zucchine grigliate', 'Olio EV Extravergine'],
        isCompleted: true,
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
      imageUrl: 'assets/images/courses/C02.png',
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
      content: 'Dopo 4 mesi di Forza Total Body, finalmente 140kg di stacco da terra puliti senza compensi. Grazie ai consigli di setup di @Coach Andrea!',
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
  ];
});
