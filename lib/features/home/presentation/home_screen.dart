import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/components/action_pill.dart';
import '../../../core/components/telemetry_tile.dart';
import '../../../core/components/section_header.dart';
import '../../../core/state/gym_state_providers.dart';
import '../../dailies/models/daily_item.dart';
import '../../dailies/presentation/daily_immersive_viewer.dart';
import '../../training/presentation/active_workout_focus_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailies = ref.watch(dailiesProvider);
    final workoutPlan = ref.watch(trainingProvider);
    final courses = ref.watch(coursesProvider);
    final nutrition = ref.watch(nutritionProvider);

    final nextClass = courses.isNotEmpty ? courses.first : null;

    return Scaffold(
      backgroundColor: AppColors.obsidianCore,
      appBar: AppBar(
        backgroundColor: AppColors.obsidianCore.withValues(alpha: 0.92),
        titleSpacing: 20,
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.volt,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Center(
                child: Text(
                  'K',
                  style: TextStyle(
                    color: AppColors.obsidianCore,
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'KINETIC CLUB',
                  style: AppTypography.tagUppercase.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
                Text(
                  'PANORAMICA',
                  style: AppTypography.headlineEditorialSm.copyWith(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.carbonSurface2,
                  backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=200&auto=format&fit=crop',
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.volt,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.obsidianCore, width: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. MODULO SALUTO ATLETA
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.volt, shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    Text('GIO 10 SET', style: AppTypography.tagUppercase.copyWith(fontSize: 12)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.verified, size: 14, color: AppColors.volt),
                      const SizedBox(width: 6),
                      Text(
                        'LIVELLO BLACK',
                        style: AppTypography.tagUppercase.copyWith(
                          color: AppColors.textPrimary,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('BUON POMERIGGIO,', style: AppTypography.displayHeroMobile.copyWith(fontSize: 20, color: AppColors.textSecondary)),
                      Text('CESARE', style: AppTypography.displayHeroMobile.copyWith(fontSize: 28, color: AppColors.textPrimary)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('STATO', style: AppTypography.tagUppercase.copyWith(fontSize: 11)),
                    Text('OTTIMALE', style: AppTypography.headlineEditorialSm.copyWith(color: AppColors.volt, fontSize: 15)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 2. HERO CARD: ALLENAMENTO DI OGGI
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.hairline),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Container(
                    height: 290,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=800&auto=format&fit=crop'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.obsidianCore.withValues(alpha: 0.3),
                            AppColors.obsidianCore.withValues(alpha: 0.7),
                            AppColors.obsidianCore.withValues(alpha: 0.98),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: AppColors.obsidianCore.withValues(alpha: 0.85),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'ALLENAMENTO DI OGGI',
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.tagUppercase.copyWith(color: AppColors.volt, fontSize: 11),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceContainerHigh.withValues(alpha: 0.85),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.bolt, size: 14, color: AppColors.volt),
                                    const SizedBox(width: 4),
                                    Text('SERIE: 18 GG', style: AppTypography.tagUppercase.copyWith(color: AppColors.textPrimary, fontSize: 11)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(workoutPlan.phase.toUpperCase(), style: AppTypography.tagUppercase.copyWith(color: AppColors.textSecondary, fontSize: 12)),
                              const SizedBox(height: 6),
                              Text(workoutPlan.title.toUpperCase(), style: AppTypography.headlineEditorialMd.copyWith(fontSize: 22)),
                              const SizedBox(height: 6),
                              Text('${workoutPlan.durationMinutes} min · Forza · Intermedio · ${workoutPlan.coachName}', style: AppTypography.bodyDefault),
                              const SizedBox(height: 16),
                              ActionPill(
                                label: 'Inizia Allenamento',
                                icon: Icons.arrow_forward,
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (_) => const ActiveWorkoutFocusScreen()),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // 3. RENDIMENTO SETTIMANALE
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.carbonSurface1,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.hairline),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          'RENDIMENTO SETTIMANALE',
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.tagUppercase.copyWith(fontSize: 11),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text('3 DI 4 SESSIONI', style: AppTypography.tagUppercase.copyWith(color: AppColors.volt, fontSize: 11, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(child: Container(height: 8, decoration: BoxDecoration(color: AppColors.volt, borderRadius: BorderRadius.circular(4)))),
                      const SizedBox(width: 6),
                      Expanded(child: Container(height: 8, decoration: BoxDecoration(color: AppColors.volt, borderRadius: BorderRadius.circular(4)))),
                      const SizedBox(width: 6),
                      Expanded(child: Container(height: 8, decoration: BoxDecoration(color: AppColors.volt, borderRadius: BorderRadius.circular(4)))),
                      const SizedBox(width: 6),
                      Expanded(child: Container(height: 8, decoration: BoxDecoration(color: AppColors.surfaceContainerHighest, borderRadius: BorderRadius.circular(4)))),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.local_fire_department, size: 16, color: AppColors.volt),
                          const SizedBox(width: 6),
                          Text('1.840 kcal bruciate', style: AppTypography.bodyDefault.copyWith(color: AppColors.textPrimary, fontSize: 13)),
                        ],
                      ),
                      Text('Prossimo: Sab 09:30', style: AppTypography.bodyCompact.copyWith(fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // 4. DAILIES HORIZONTAL RAIL
            SectionHeader(
              title: 'Notizie & Dailies',
              badgeText: '04 NUOVI',
              actionLabel: 'Tutti (${dailies.length})',
              onAction: () {
                if (dailies.isNotEmpty) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => DailyImmersiveViewer(item: dailies.first)));
                }
              },
            ),
            SizedBox(
              height: 160,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: dailies.take(8).length,
                separatorBuilder: (_, __) => const SizedBox(width: 14),
                itemBuilder: (context, index) {
                  final daily = dailies[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => DailyImmersiveViewer(item: daily)));
                    },
                    child: Container(
                      width: 165,
                      decoration: BoxDecoration(
                        color: AppColors.carbonSurface1,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.hairline),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        children: [
                          Image.network(
                            daily.imageUrl,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(color: AppColors.carbonSurface2),
                          ),
                          Container(
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
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: AppColors.obsidianCore.withValues(alpha: 0.85),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: Text(
                                    daily.category.tagCode,
                                    style: AppTypography.tagUppercase.copyWith(color: AppColors.volt, fontSize: 10),
                                  ),
                                ),
                                Text(
                                  daily.title.toUpperCase(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.headlineEditorialSm.copyWith(fontSize: 14, height: 1.2),
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
            const SizedBox(height: 28),

            // 5. PROSSIMA LEZIONE SCHEDULATA
            if (nextClass != null) ...[
              SectionHeader(title: 'Prossima Lezione', actionLabel: 'Vedi Tutte'),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.carbonSurface1,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.hairline),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.carbonSurface2,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.hairline),
                      ),
                      child: const Center(
                        child: Icon(Icons.fitness_center, color: AppColors.volt, size: 24),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(nextClass.courseName.toUpperCase(), style: AppTypography.headlineEditorialSm.copyWith(fontSize: 16)),
                          const SizedBox(height: 3),
                          Text('Oggi · ${nextClass.durationMinutes}m · ${nextClass.trainerName}', style: AppTypography.bodyDefault),
                          const SizedBox(height: 3),
                          Text('${nextClass.spotsRemaining} posti · ${nextClass.room}', style: AppTypography.tagUppercase.copyWith(color: AppColors.volt, fontSize: 11)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: nextClass.isBookedByUser ? AppColors.surfaceContainerHigh : AppColors.volt,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        nextClass.isBookedByUser ? 'PRENOTATO' : 'PRENOTA',
                        style: AppTypography.tagUppercase.copyWith(
                          color: nextClass.isBookedByUser ? AppColors.volt : AppColors.onVolt,
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
            ],

            // 6. SNAPSHOT NUTRIZIONE
            SectionHeader(title: 'Nutrizione Oggi', actionLabel: 'Dettagli'),
            Row(
              children: [
                Expanded(
                  child: TelemetryTile(
                    label: 'Proteine',
                    value: '${nutrition.consumedProteinG}',
                    unit: '/ ${nutrition.targetProteinG}g',
                    statusText: '${nutrition.targetProteinG - nutrition.consumedProteinG}g mancanti',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TelemetryTile(
                    label: 'Calorie',
                    value: '${nutrition.consumedCalories}',
                    unit: '/ ${nutrition.targetCalories}kcal',
                    statusText: '${nutrition.targetCalories - nutrition.consumedCalories} kcal rimaste',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
