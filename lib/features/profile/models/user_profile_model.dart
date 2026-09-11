class UserProfile {
  final String fullName;
  final String membershipLevel;
  final int age;
  final int heightCm;
  final double weightKg;
  final String fitnessLevel; // Principiante, Intermedio, Avanzato
  final String primaryGoal; // Forza & Ipertrofia, Tonicità & Definizione, Resistenza, Mobilità
  final String? avatarPath;

  const UserProfile({
    this.fullName = 'CESARE NEGRO',
    this.membershipLevel = 'BLACK ELITE',
    this.age = 28,
    this.heightCm = 180,
    this.weightKg = 78.0,
    this.fitnessLevel = 'Intermedio',
    this.primaryGoal = 'Forza & Ipertrofia',
    this.avatarPath,
  });

  double get bmi {
    if (heightCm <= 0) return 22.0;
    final hMeter = heightCm / 100.0;
    return weightKg / (hMeter * hMeter);
  }

  String get bmiCategory {
    final val = bmi;
    if (val < 18.5) return 'Sottopeso';
    if (val < 25.0) return 'Normopeso';
    if (val < 30.0) return 'Struttura Atletica';
    return 'Alta Massa / Strutturato';
  }

  double get loadMultiplier {
    switch (fitnessLevel.toLowerCase()) {
      case 'principiante':
        return 0.45;
      case 'avanzato':
        return 0.95;
      case 'intermedio':
      default:
        return 0.70;
    }
  }

  UserProfile copyWith({
    String? fullName,
    String? membershipLevel,
    int? age,
    int? heightCm,
    double? weightKg,
    String? fitnessLevel,
    String? primaryGoal,
    String? avatarPath,
  }) {
    return UserProfile(
      fullName: fullName ?? this.fullName,
      membershipLevel: membershipLevel ?? this.membershipLevel,
      age: age ?? this.age,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      fitnessLevel: fitnessLevel ?? this.fitnessLevel,
      primaryGoal: primaryGoal ?? this.primaryGoal,
      avatarPath: avatarPath ?? this.avatarPath,
    );
  }
}
