import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/state/gym_state_providers.dart';
import '../models/user_profile_model.dart';

class OnboardingBiometricModal extends ConsumerStatefulWidget {
  const OnboardingBiometricModal({super.key});

  @override
  ConsumerState<OnboardingBiometricModal> createState() => _OnboardingBiometricModalState();
}

class _OnboardingBiometricModalState extends ConsumerState<OnboardingBiometricModal> {
  late double _weightKg;
  late int _heightCm;
  late int _age;
  late String _fitnessLevel;
  late String _primaryGoal;

  final List<String> _fitnessLevels = ['Principiante', 'Intermedio', 'Avanzato'];
  final List<String> _goals = [
    'Forza & Ipertrofia',
    'Tonicità & Definizione',
    'Resistenza Cardio',
    'Mobilità & Reset',
  ];

  @override
  void initState() {
    super.initState();
    final profile = ref.read(userProfileProvider);
    _weightKg = profile.weightKg;
    _heightCm = profile.heightCm;
    _age = profile.age;
    _fitnessLevel = profile.fitnessLevel;
    _primaryGoal = profile.primaryGoal;
  }

  @override
  Widget build(BuildContext context) {
    final activeColor = context.isCoolTheme ? AppColors.coolAccent : AppColors.volt;
    final activeTextColor = context.isCoolTheme ? AppColors.coolOnAccent : AppColors.onVolt;

    return Container(
      decoration: BoxDecoration(
        color: context.cardBg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        border: Border.all(color: context.hairlineColor),
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: context.hairlineColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('PROFILO BIOMETRICO ATLETA', style: AppTypography.tagUppercase.copyWith(fontSize: 10, color: activeColor)),
                    Text('DATI FISICI & CARICHI', style: AppTypography.headlineEditorialSm.copyWith(fontSize: 18, color: context.textPrimaryColor)),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.close, color: context.textSecondaryColor),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 1. PESO CORPOREO (KG)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('PESO CORPOREO', style: AppTypography.tagUppercase.copyWith(fontSize: 11, color: context.textSecondaryColor)),
                Text('${_weightKg.toStringAsFixed(1)} KG', style: AppTypography.headlineEditorialSm.copyWith(fontSize: 18, color: activeColor)),
              ],
            ),
            Slider(
              value: _weightKg,
              min: 40.0,
              max: 140.0,
              divisions: 200,
              activeColor: activeColor,
              inactiveColor: context.hairlineColor,
              onChanged: (val) => setState(() => _weightKg = val),
            ),
            const SizedBox(height: 16),

            // 2. ALTEZZA (CM) & ETÀ
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('ALTEZZA', style: AppTypography.tagUppercase.copyWith(fontSize: 11, color: context.textSecondaryColor)),
                          Text('$_heightCm cm', style: AppTypography.bodyDefault.copyWith(fontWeight: FontWeight.bold, color: context.textPrimaryColor)),
                        ],
                      ),
                      Slider(
                        value: _heightCm.toDouble(),
                        min: 140.0,
                        max: 215.0,
                        divisions: 75,
                        activeColor: activeColor,
                        inactiveColor: context.hairlineColor,
                        onChanged: (val) => setState(() => _heightCm = val.toInt()),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('ETÀ', style: AppTypography.tagUppercase.copyWith(fontSize: 11, color: context.textSecondaryColor)),
                          Text('$_age anni', style: AppTypography.bodyDefault.copyWith(fontWeight: FontWeight.bold, color: context.textPrimaryColor)),
                        ],
                      ),
                      Slider(
                        value: _age.toDouble(),
                        min: 16.0,
                        max: 85.0,
                        divisions: 69,
                        activeColor: activeColor,
                        inactiveColor: context.hairlineColor,
                        onChanged: (val) => setState(() => _age = val.toInt()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 3. LIVELLO DI FORMA FISICA
            Text('LIVELLO DI FORMA FISICA', style: AppTypography.tagUppercase.copyWith(fontSize: 11, color: context.textSecondaryColor)),
            const SizedBox(height: 8),
            Row(
              children: _fitnessLevels.map((lvl) {
                final isSelected = _fitnessLevel == lvl;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: GestureDetector(
                      onTap: () => setState(() => _fitnessLevel = lvl),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? activeColor : context.cardBg2,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: isSelected ? activeColor : context.hairlineColor),
                        ),
                        child: Center(
                          child: Text(
                            lvl.toUpperCase(),
                            style: AppTypography.tagUppercase.copyWith(
                              fontSize: 10,
                              color: isSelected ? activeTextColor : context.textPrimaryColor,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // 4. OBIETTIVO PRIMARIO
            Text('OBIETTIVO PRINCIPALE', style: AppTypography.tagUppercase.copyWith(fontSize: 11, color: context.textSecondaryColor)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _goals.map((g) {
                final isSelected = _primaryGoal == g;
                return GestureDetector(
                  onTap: () => setState(() => _primaryGoal = g),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? activeColor : context.cardBg2,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: isSelected ? activeColor : context.hairlineColor),
                    ),
                    child: Text(
                      g.toUpperCase(),
                      style: AppTypography.tagUppercase.copyWith(
                        fontSize: 10,
                        color: isSelected ? activeTextColor : context.textPrimaryColor,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // SAVE BUTTON
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: activeColor,
                  foregroundColor: activeTextColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  ref.read(userProfileProvider.notifier).updateProfile(
                        weightKg: _weightKg,
                        heightCm: _heightCm,
                        age: _age,
                        fitnessLevel: _fitnessLevel,
                        primaryGoal: _primaryGoal,
                      );
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: context.cardBg2,
                      content: Text(
                        'Profilo aggiornato! Carichi in KG ricalcolati per il tuo livello.',
                        style: AppTypography.bodyDefault.copyWith(color: activeColor),
                      ),
                    ),
                  );
                },
                child: Text(
                  'SALVA E RICALCOLA CARICHI (KG)',
                  style: AppTypography.tagUppercase.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: activeTextColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
