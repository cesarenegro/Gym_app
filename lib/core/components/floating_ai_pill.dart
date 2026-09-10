import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class FloatingAiPill extends StatelessWidget {
  final VoidCallback onTap;

  const FloatingAiPill({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.carbonSurface1.withOpacity(0.95),
          borderRadius: BorderRadius.circular(9999),
          border: Border.all(color: AppColors.volt, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: AppColors.volt.withOpacity(0.25),
              blurRadius: 16,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '✦',
              style: TextStyle(color: AppColors.volt, fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 6),
            Text(
              'GYM AI',
              style: AppTypography.tagUppercase.copyWith(
                color: AppColors.volt,
                fontWeight: FontWeight.w700,
                fontSize: 11,
                letterSpacing: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
