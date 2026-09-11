import '../../features/profile/models/user_profile_model.dart';

abstract class LoadCalculator {
  static String calculateRecommendedLoad({
    required String exerciseName,
    required UserProfile profile,
    String? equipment,
  }) {
    final lowerName = exerciseName.toLowerCase();
    final equipLower = (equipment ?? '').toLowerCase();

    // Bodyweight movements
    if (lowerName.contains('plank') ||
        lowerName.contains('jumping') ||
        lowerName.contains('crunch') ||
        lowerName.contains('bird dog') ||
        lowerName.contains('mountain climber') ||
        lowerName.contains('corsa') ||
        lowerName.contains('marcia') ||
        lowerName.contains('salto') ||
        lowerName.contains('stretching') ||
        equipLower.contains('bodyweight') ||
        equipLower.contains('corpo libero')) {
      return 'Corpo Libero';
    }

    double movementFactor = 0.35;

    if (lowerName.contains('stacco') || lowerName.contains('deadlift')) {
      movementFactor = 0.85;
    } else if (lowerName.contains('squat') || lowerName.contains('leg press')) {
      movementFactor = 0.65;
    } else if (lowerName.contains('panca') || lowerName.contains('chest press') || lowerName.contains('spinta')) {
      movementFactor = 0.45;
    } else if (lowerName.contains('rematore') || lowerName.contains('lat') || lowerName.contains('pulley') || lowerName.contains('row')) {
      movementFactor = 0.40;
    } else if (lowerName.contains('affondi') || lowerName.contains('step')) {
      movementFactor = 0.30;
    } else if (lowerName.contains('bicipiti') || lowerName.contains('curl') || lowerName.contains('tricipiti') || lowerName.contains('alzate')) {
      movementFactor = 0.15;
    }

    final rawKg = profile.weightKg * profile.loadMultiplier * movementFactor;

    // Round to nearest 2kg interval
    final roundedKg = ((rawKg / 2.0).round() * 2).clamp(4, 120);

    if (lowerName.contains('bicipiti') || lowerName.contains('alzate') || lowerName.contains('affondi')) {
      final perHandKg = (roundedKg / 2.0).round();
      return '$perHandKg kg x hand';
    }

    return '$roundedKg kg';
  }
}
