import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/components/telemetry_tile.dart';
import '../../../core/components/section_header.dart';
import '../../../core/state/gym_state_providers.dart';
import '../models/nutrition_models.dart';

class NutritionScreen extends ConsumerWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nutrition = ref.watch(nutritionProvider);

    return Scaffold(
      backgroundColor: AppColors.obsidianCore,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('NUTRIZIONE & MACRO', style: AppTypography.tagUppercase.copyWith(fontSize: 9)),
            Text('NUTRITION', style: AppTypography.headlineEditorialSm),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Telemetry Grid
            SectionHeader(title: 'Bilancio Giornaliero'),
            Row(
              children: [
                Expanded(
                  child: TelemetryTile(
                    label: 'CALORIE',
                    value: '${nutrition.consumedCalories}',
                    unit: '/ ${nutrition.targetCalories} kcal',
                    statusText: '${nutrition.targetCalories - nutrition.consumedCalories} kcal rimanenti',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TelemetryTile(
                    label: 'PROTEINE',
                    value: '${nutrition.consumedProteinG}',
                    unit: '/ ${nutrition.targetProteinG} g',
                    statusText: '${nutrition.targetProteinG - nutrition.consumedProteinG}g mancanti',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TelemetryTile(
                    label: 'CARBOIDRATI',
                    value: '${nutrition.consumedCarbsG}',
                    unit: '/ ${nutrition.targetCarbsG} g',
                    statusColor: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TelemetryTile(
                    label: 'GRASSI',
                    value: '${nutrition.consumedFatG}',
                    unit: '/ ${nutrition.targetFatG} g',
                    statusColor: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Meals List with Assigned vs AI distinction
            SectionHeader(
              title: 'Pasti del Giorno',
              badgeText: '${nutrition.meals.length} PASTI',
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: nutrition.meals.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, idx) {
                final meal = nutrition.meals[idx];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.carbonSurface1,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.hairline),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(meal.title.toUpperCase(), style: AppTypography.headlineEditorialSm.copyWith(fontSize: 14)),
                              const SizedBox(width: 8),
                              if (meal.isCompleted)
                                const Icon(Icons.check_circle, size: 16, color: AppColors.volt),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: meal.source == PlanSource.professionalAssigned
                                  ? AppColors.surfaceContainerHigh
                                  : AppColors.carbonSurface2,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: meal.source == PlanSource.professionalAssigned
                                    ? AppColors.hairline
                                    : AppColors.volt,
                                width: 0.8,
                              ),
                            ),
                            child: Text(
                              meal.source == PlanSource.professionalAssigned
                                  ? 'PIANO PROFESSIONALE'
                                  : '✦ SUGGERITO DA AI',
                              style: AppTypography.tagUppercase.copyWith(
                                color: meal.source == PlanSource.professionalAssigned
                                    ? AppColors.textSecondary
                                    : AppColors.volt,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${meal.calories} kcal · ${meal.proteinG}g PRO · ${meal.carbsG}g CHO · ${meal.fatG}g FAT',
                        style: AppTypography.tagUppercase.copyWith(color: AppColors.volt, fontSize: 10),
                      ),
                      const SizedBox(height: 8),
                      ...meal.foods.map(
                        (f) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text('• $f', style: AppTypography.bodyCompact),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
