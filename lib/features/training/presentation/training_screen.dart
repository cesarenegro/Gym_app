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

  Widget _buildImage(String path) {
    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(color: AppColors.carbonSurface2),
      );
    }
    return Image.network(
      path,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(color: AppColors.carbonSurface2),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activePlan = ref.watch(trainingProvider);
    final allWorkouts = ref.watch(workoutsListProvider);

    return Scaffold(
      backgroundColor: AppColors.obsidianCore,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('CATALOGO ALLENAMENTI', style: AppTypography.tagUppercase.copyWith(fontSize: 11)),
            Text('WORKOUT ROUTINES', style: AppTypography.headlineEditorialSm.copyWith(fontSize: 18)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Horizontal Workout Selector Rail (All 20 Workouts)
            Container(
              height: 140,
              margin: const EdgeInsets.only(top: 12, bottom: 16),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: allWorkouts.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final w = allWorkouts[index];
                  final isSelected = w.id == activePlan.id;
                  return GestureDetector(
                    onTap: () {
                      ref.read(trainingProvider.notifier).selectWorkout(w);
                    },
                    child: Container(
                      width: 160,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.volt.withValues(alpha: 0.15) : AppColors.carbonSurface1,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: isSelected ? AppColors.volt : AppColors.hairline, width: isSelected ? 2 : 1),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: _buildImage(w.imageUrl),
                          ),
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    AppColors.obsidianCore.withValues(alpha: 0.92),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.obsidianCore.withValues(alpha: 0.85),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: Text(
                                    w.id,
                                    style: AppTypography.tagUppercase.copyWith(color: isSelected ? AppColors.volt : AppColors.textPrimary, fontSize: 10),
                                  ),
                                ),
                                Text(
                                  w.title.toUpperCase(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.headlineEditorialSm.copyWith(fontSize: 13, height: 1.2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Program Overview Card
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.carbonSurface1,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.hairline),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (activePlan.imageUrl.isNotEmpty)
                          SizedBox(
                            height: 180,
                            width: double.infinity,
                            child: _buildImage(activePlan.imageUrl),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(activePlan.phase.toUpperCase(), style: AppTypography.tagUppercase.copyWith(color: AppColors.volt, fontSize: 12)),
                                  Text('RPE ${activePlan.intensityRpe}', style: AppTypography.tagUppercase.copyWith(fontSize: 11, color: AppColors.textSecondary)),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(activePlan.title.toUpperCase(), style: AppTypography.headlineEditorialMd.copyWith(fontSize: 24)),
                              const SizedBox(height: 6),
                              Text(activePlan.splitName, style: AppTypography.bodyDefault.copyWith(color: AppColors.textSecondary)),
                              const SizedBox(height: 18),

                              Row(
                                children: [
                                  Expanded(
                                    child: TelemetryTile(
                                      label: 'DURATA',
                                      value: '${activePlan.durationMinutes}',
                                      unit: 'MIN',
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TelemetryTile(
                                      label: 'ROUND',
                                      value: '${activePlan.rounds}',
                                      unit: 'GIRI',
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TelemetryTile(
                                      label: 'ESERCIZI',
                                      value: '${activePlan.exercises.length}',
                                      unit: 'TOTALI',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18),

                              // Attrezzatura richiesta
                              if (activePlan.equipment.isNotEmpty) ...[
                                Text('ATTREZZATURA', style: AppTypography.tagUppercase.copyWith(fontSize: 11, color: AppColors.textSecondary)),
                                const SizedBox(height: 6),
                                Wrap(
                                  spacing: 6,
                                  runSpacing: 6,
                                  children: activePlan.equipment.map((eq) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: AppColors.carbonSurface2,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(eq, style: AppTypography.bodyCompact.copyWith(color: AppColors.textPrimary, fontSize: 12)),
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(height: 18),
                              ],

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
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Warmup Section
                  if (activePlan.warmupInstructions.isNotEmpty) ...[
                    SectionHeader(title: 'Riscaldamento', badgeText: '${activePlan.warmupMinutes} MINUTI'),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.carbonSurface1,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.hairline),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.wb_sunny_outlined, color: AppColors.volt, size: 22),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              activePlan.warmupInstructions,
                              style: AppTypography.bodyDefault.copyWith(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Exercise List
                  SectionHeader(
                    title: 'Esercizi del Circuito',
                    badgeText: '${activePlan.exercises.length} MOVIMENTI',
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: activePlan.exercises.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      final ex = activePlan.exercises[index];
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
                                    Text(ex.name.toUpperCase(), style: AppTypography.headlineEditorialSm.copyWith(fontSize: 16)),
                                  ],
                                ),
                                Text('Recupero: ${ex.restSeconds}s', style: AppTypography.bodyDefault.copyWith(color: AppColors.textSecondary, fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text('DOSE: ${ex.targetSetsReps}', style: AppTypography.bodyDefault.copyWith(color: AppColors.volt, fontWeight: FontWeight.bold)),
                            if (ex.instructions.isNotEmpty) ...[
                              const SizedBox(height: 6),
                              Text(ex.instructions, style: AppTypography.bodyDefault.copyWith(fontSize: 14, color: AppColors.textPrimary)),
                            ],
                            if (ex.easierOption.isNotEmpty) ...[
                              const SizedBox(height: 6),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Opzione più facile: ', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold, fontSize: 13)),
                                  Expanded(
                                    child: Text(ex.easierOption, style: AppTypography.bodyCompact.copyWith(fontSize: 13)),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  // Cooldown Section
                  if (activePlan.cooldownInstructions.isNotEmpty) ...[
                    SectionHeader(title: 'Defaticamento', badgeText: '${activePlan.cooldownMinutes} MINUTI'),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.carbonSurface1,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.hairline),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.nightlight_round, color: AppColors.volt, size: 22),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              activePlan.cooldownInstructions,
                              style: AppTypography.bodyDefault.copyWith(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
