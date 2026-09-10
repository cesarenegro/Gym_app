import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/components/action_pill.dart';
import '../../../core/components/section_header.dart';
import '../../../core/components/telemetry_tile.dart';
import '../../../core/state/gym_state_providers.dart';
import 'active_workout_focus_screen.dart';

class TrainingScreen extends ConsumerWidget {
  const TrainingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plan = ref.watch(trainingProvider);

    return Scaffold(
      backgroundColor: AppColors.obsidianCore,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('PROGRAMMA ATLETA', style: AppTypography.tagUppercase.copyWith(fontSize: 11)),
            Text('ALLENAMENTO', style: AppTypography.headlineEditorialSm.copyWith(fontSize: 18)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Program Overview Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.carbonSurface1,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.hairline),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(plan.phase.toUpperCase(), style: AppTypography.tagUppercase.copyWith(color: AppColors.volt, fontSize: 12)),
                      Text('PROGRAMMA ATTIVO', style: AppTypography.tagUppercase.copyWith(fontSize: 11)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(plan.title.toUpperCase(), style: AppTypography.headlineEditorialMd.copyWith(fontSize: 24)),
                  const SizedBox(height: 6),
                  Text(plan.splitName, style: AppTypography.bodyDefault.copyWith(color: AppColors.textSecondary)),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: TelemetryTile(
                          label: 'DURATA',
                          value: '${plan.durationMinutes}',
                          unit: 'MIN',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TelemetryTile(
                          label: 'ESERCIZI',
                          value: '${plan.exercises.length}',
                          unit: 'TOTALI',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ActionPill(
                    label: 'Avvia Modalità Focus',
                    icon: Icons.play_arrow,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const ActiveWorkoutFocusScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Exercise List
            SectionHeader(
              title: 'Esercizi del Giorno',
              badgeText: '${plan.exercises.length} MOVIMENTI',
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: plan.exercises.length,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final ex = plan.exercises[index];
                return Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.carbonSurface1,
                    borderRadius: BorderRadius.circular(10),
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
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: AppColors.carbonSurface2,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  child: Text(
                                    '${index + 1}',
                                    style: AppTypography.tagUppercase.copyWith(
                                      color: AppColors.volt,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(ex.muscleGroup.toUpperCase(), style: AppTypography.tagUppercase.copyWith(fontSize: 12)),
                            ],
                          ),
                          Text('Recupero: ${ex.restSeconds}s', style: AppTypography.bodyDefault.copyWith(color: AppColors.textSecondary)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(ex.name.toUpperCase(), style: AppTypography.headlineEditorialSm.copyWith(fontSize: 16)),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Target: ${ex.targetSetsReps}', style: AppTypography.bodyDefault.copyWith(color: AppColors.volt, fontWeight: FontWeight.bold)),
                          Text('Record: ${ex.previousBest}', style: AppTypography.bodyDefault.copyWith(color: AppColors.textSecondary)),
                        ],
                      ),
                      if (ex.notes.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text('Note: ${ex.notes}', style: AppTypography.bodyDefault.copyWith(fontStyle: FontStyle.italic, color: AppColors.textSecondary)),
                      ],
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
