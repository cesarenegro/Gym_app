import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/components/action_pill.dart';
import '../../../core/state/gym_state_providers.dart';
import '../../../core/utils/load_calculator.dart';

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
    final userProfile = ref.watch(userProfileProvider);
    final activeColor = context.isCoolTheme ? AppColors.coolAccent : AppColors.volt;
    final activeTextColor = context.isCoolTheme ? AppColors.coolOnAccent : AppColors.onVolt;

    return Scaffold(
      backgroundColor: context.appBg,
      appBar: AppBar(
        backgroundColor: context.appBg.withValues(alpha: 0.92),
        leading: IconButton(
          icon: Icon(Icons.close, color: context.textPrimaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('MODALITÀ FOCUS ATTIVA', style: AppTypography.tagUppercase.copyWith(color: activeColor, fontSize: 9)),
            Text(plan.title.toUpperCase(), style: AppTypography.headlineEditorialSm.copyWith(fontSize: 14, color: context.textPrimaryColor)),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: context.cardBg2,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: context.hairlineColor),
            ),
            child: Row(
              children: [
                Icon(Icons.timer_outlined, size: 14, color: activeColor),
                const SizedBox(width: 4),
                Text(
                  _formatTime(_secondsElapsed),
                  style: AppTypography.metricNumeralMd.copyWith(fontSize: 13, color: context.textPrimaryColor),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.appBg,
          border: Border(top: BorderSide(color: context.hairlineColor)),
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
                    color: context.cardBg2,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: activeColor),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.hourglass_top, size: 14, color: activeColor),
                      const SizedBox(width: 6),
                      Text(
                        'RECUPERO: ${_restTimerSeconds}s',
                        style: AppTypography.tagUppercase.copyWith(color: activeColor),
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
                      backgroundColor: context.cardBg,
                      title: Text('OTTIMO LAVORO!', style: AppTypography.headlineEditorialMd.copyWith(color: activeColor)),
                      content: Text(
                        'Hai completato la sessione in ${_formatTime(_secondsElapsed)}.\nTutti i carichi e le serie sono stati registrati nello storico.',
                        style: AppTypography.bodyDefault.copyWith(color: context.textPrimaryColor),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            Navigator.of(context).pop();
                          },
                          child: Text('CHIUDI', style: AppTypography.tagUppercase.copyWith(color: activeColor)),
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
          final recLoad = LoadCalculator.calculateRecommendedLoad(
            exerciseName: ex.name,
            profile: userProfile,
          );

          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.cardBg,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: context.hairlineColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(ex.name.toUpperCase(), style: AppTypography.headlineEditorialSm.copyWith(color: context.textPrimaryColor)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: activeColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(recLoad, style: AppTypography.tagUppercase.copyWith(color: activeColor, fontSize: 11, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Sets Table Header
                Row(
                  children: [
                    SizedBox(width: 40, child: Text('SET', style: AppTypography.tagUppercase.copyWith(fontSize: 9, color: context.textSecondaryColor))),
                    Expanded(child: Text('TARGET', style: AppTypography.tagUppercase.copyWith(fontSize: 9, color: context.textSecondaryColor))),
                    Expanded(child: Text('ESECUTO', style: AppTypography.tagUppercase.copyWith(fontSize: 9, color: context.textSecondaryColor))),
                    SizedBox(width: 44, child: Center(child: Icon(Icons.check, size: 14, color: context.textSecondaryColor))),
                  ],
                ),
                Divider(color: context.hairlineColor, height: 16),
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
                          child: Text('${s.setNumber}', style: AppTypography.tagUppercase.copyWith(color: context.textPrimaryColor)),
                        ),
                        Expanded(
                          child: Text('$recLoad × ${s.targetReps}', style: AppTypography.bodyCompact.copyWith(color: context.textPrimaryColor)),
                        ),
                        Expanded(
                          child: Text(
                            s.isCompleted ? '$recLoad × ${s.completedReps}' : '—',
                            style: AppTypography.bodyDefault.copyWith(
                              color: s.isCompleted ? activeColor : context.textSecondaryColor,
                              fontWeight: s.isCompleted ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 44,
                          child: IconButton(
                            icon: Icon(
                              s.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                              color: s.isCompleted ? activeColor : context.textSecondaryColor,
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
