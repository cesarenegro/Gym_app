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
            Text('PROGRAMMA ATLETA', style: AppTypography.tagUppercase.copyWith(fontSize: 9)),
            Text('TRAINING', style: AppTypography.headlineEditorialSm),
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
              padding: const EdgeInsets.all(18),
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
                      Text(plan.phase.toUpperCase(), style: AppTypography.tagUppercase.copyWith(color: AppColors.volt)),
                      Text('PROGRAMMA ATTIVO', style: AppTypography.tagUppercase.copyWith(fontSize: 9)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(plan.title.toUpperCase(), style: AppTypography.headlineEditorialMd.copyWith(fontSize: 22)),
                  const SizedBox(height: 4),
                  Text(plan.splitName, style: AppTypography.bodyDefault.copyWith(color: AppColors.textSecondary)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TelemetryTile(
                          label: 'DURATA',
                          value: '${plan.durationMinutes}',
                          unit: 'MIN',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TelemetryTile(
                          label: 'ESERCIZI',
                          value: '${plan.exercises.length}',
                          unit: 'TOTALI',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
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
            const SizedBox(height: 24),

            // Exercise List
            SectionHeader(
              title: 'Esercizi del Giorno',
              badgeText: '${plan.exercises.length} MOVIMENTI',
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: plan.exercises.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final ex = plan.exercises[index];
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
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: AppColors.carbonSurface2,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    '${index + 1}',
                                    style: AppTypography.tagUppercase.copyWith(
                                      color: AppColors.volt,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(ex.muscleGroup.toUpperCase(), style: AppTypography.tagUppercase.copyWith(fontSize: 10)),
                            ],
                          ),
                          Text('Recupero: ${ex.restSeconds}s', style: AppTypography.bodyCompact),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(ex.name.toUpperCase(), style: AppTypography.headlineEditorialSm),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Target: ${ex.targetSetsReps}', style: AppTypography.bodyDefault.copyWith(color: AppColors.volt)),
                          Text('Record: ${ex.previousBest}', style: AppTypography.bodyCompact),
                        ],
                      ),
                      if (ex.notes.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text('Note: ${ex.notes}', style: AppTypography.bodyCompact.copyWith(fontStyle: FontStyle.italic)),
                      ],
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
