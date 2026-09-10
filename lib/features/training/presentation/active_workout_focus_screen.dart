import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/components/action_pill.dart';
import '../../../core/state/gym_state_providers.dart';

class ActiveWorkoutFocusScreen extends ConsumerStatefulWidget {
  const ActiveWorkoutFocusScreen({super.key});

  @override
  ConsumerState<ActiveWorkoutFocusScreen> createState() => _ActiveWorkoutFocusScreenState();
}

class _ActiveWorkoutFocusScreenState extends ConsumerState<ActiveWorkoutFocusScreen> {
  int _secondsElapsed = 0;
  Timer? _timer;
  int _restTimerSeconds = 0;
  Timer? _restTimer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) setState(() => _secondsElapsed++);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _restTimer?.cancel();
    super.dispose();
  }

  void _startRestTimer(int seconds) {
    _restTimer?.cancel();
    setState(() => _restTimerSeconds = seconds);
    _restTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_restTimerSeconds > 0) {
        if (mounted) setState(() => _restTimerSeconds--);
      } else {
        t.cancel();
      }
    });
  }

  String _formatTime(int totalSecs) {
    final m = (totalSecs ~/ 60).toString().padLeft(2, '0');
    final s = (totalSecs % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final plan = ref.watch(trainingProvider);

    return Scaffold(
      backgroundColor: AppColors.obsidianCore,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('MODALITÀ FOCUS ATTIVA', style: AppTypography.tagUppercase.copyWith(color: AppColors.volt, fontSize: 9)),
            Text(plan.title.toUpperCase(), style: AppTypography.headlineEditorialSm.copyWith(fontSize: 14)),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.carbonSurface2,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppColors.hairline),
            ),
            child: Row(
              children: [
                const Icon(Icons.timer_outlined, size: 14, color: AppColors.volt),
                const SizedBox(width: 4),
                Text(
                  _formatTime(_secondsElapsed),
                  style: AppTypography.metricNumeralMd.copyWith(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.obsidianCore,
          border: const Border(top: BorderSide(color: AppColors.hairline)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_restTimerSeconds > 0) ...[
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.carbonSurface2,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: AppColors.volt),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.hourglass_top, size: 14, color: AppColors.volt),
                      const SizedBox(width: 6),
                      Text(
                        'RECUPERO: ${_restTimerSeconds}s',
                        style: AppTypography.tagUppercase.copyWith(color: AppColors.volt),
                      ),
                    ],
                  ),
                ),
              ],
              ActionPill(
                label: 'Concludi Workout & Salva',
                icon: Icons.check,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      backgroundColor: AppColors.carbonSurface1,
                      title: Text('OTTIMO LAVORO!', style: AppTypography.headlineEditorialMd.copyWith(color: AppColors.volt)),
                      content: Text(
                        'Hai completato la sessione in ${_formatTime(_secondsElapsed)}.\nTutti i carichi e le serie sono stati registrati nello storico.',
                        style: AppTypography.bodyDefault,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            Navigator.of(context).pop();
                          },
                          child: Text('CHIUDI', style: AppTypography.tagUppercase.copyWith(color: AppColors.volt)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: plan.exercises.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, exIdx) {
          final ex = plan.exercises[exIdx];
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
                    Text(ex.name.toUpperCase(), style: AppTypography.headlineEditorialSm),
                    Text(ex.targetSetsReps, style: AppTypography.tagUppercase.copyWith(color: AppColors.volt)),
                  ],
                ),
                const SizedBox(height: 12),
                // Sets Table Header
                Row(
                  children: [
                    SizedBox(width: 40, child: Text('SET', style: AppTypography.tagUppercase.copyWith(fontSize: 9))),
                    Expanded(child: Text('TARGET', style: AppTypography.tagUppercase.copyWith(fontSize: 9))),
                    Expanded(child: Text('CARICO / REP', style: AppTypography.tagUppercase.copyWith(fontSize: 9))),
                    const SizedBox(width: 44, child: Center(child: Icon(Icons.check, size: 14, color: AppColors.textSecondary))),
                  ],
                ),
                const Divider(color: AppColors.hairline, height: 16),
                // Sets Rows
                ...ex.sets.asMap().entries.map((entry) {
                  final setIdx = entry.key;
                  final s = entry.value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 40,
                          child: Text('${s.setNumber}', style: AppTypography.tagUppercase.copyWith(color: AppColors.textPrimary)),
                        ),
                        Expanded(
                          child: Text('${s.targetWeightKg}kg × ${s.targetReps}', style: AppTypography.bodyCompact),
                        ),
                        Expanded(
                          child: Text(
                            s.isCompleted ? '${s.completedWeightKg}kg × ${s.completedReps}' : '—',
                            style: AppTypography.bodyDefault.copyWith(
                              color: s.isCompleted ? AppColors.volt : AppColors.textSecondary,
                              fontWeight: s.isCompleted ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 44,
                          child: IconButton(
                            icon: Icon(
                              s.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                              color: s.isCompleted ? AppColors.volt : AppColors.hairlineLight,
                              size: 22,
                            ),
                            onPressed: () {
                              ref.read(trainingProvider.notifier).toggleSetComplete(ex.id, setIdx);
                              if (!s.isCompleted) {
                                _startRestTimer(ex.restSeconds);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
