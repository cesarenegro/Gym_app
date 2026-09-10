import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class TelemetryTile extends StatelessWidget {
  final String label;
  final String value;
  final String? unit;
  final String? statusText;
  final Color? statusColor;
  final Widget? trailing;

  const TelemetryTile({
    super.key,
    required this.label,
    required this.value,
    this.unit,
    this.statusText,
    this.statusColor,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.carbonSurface1,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.hairline, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  label.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.tagUppercase.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 9,
                  ),
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: 6),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: AppTypography.metricNumeralMd.copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 20,
                  ),
                ),
                if (unit != null) ...[
                  const SizedBox(width: 4),
                  Text(
                    unit!,
                    style: AppTypography.bodyCompact.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (statusText != null) ...[
            const SizedBox(height: 4),
            Text(
              statusText!,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: AppTypography.tagUppercase.copyWith(
                fontSize: 9,
                color: statusColor ?? AppColors.volt,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
