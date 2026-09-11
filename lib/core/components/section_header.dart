import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? badgeText;
  final String? actionLabel;
  final VoidCallback? onAction;

  const SectionHeader({
    super.key,
    required this.title,
    this.badgeText,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    title.toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.headlineEditorialSm.copyWith(
                      fontSize: 15,
                      letterSpacing: -0.2,
                      color: context.textPrimaryColor,
                    ),
                  ),
                ),
                if (badgeText != null) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: context.isCoolTheme ? AppColors.coolAccent : AppColors.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      badgeText!,
                      style: AppTypography.tagUppercase.copyWith(
                        color: context.isCoolTheme ? AppColors.coolOnAccent : AppColors.volt,
                        fontSize: 9,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (actionLabel != null) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onAction,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    actionLabel!.toUpperCase(),
                    style: AppTypography.tagUppercase.copyWith(
                      color: context.textSecondaryColor,
                      fontSize: 10,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Icon(
                    Icons.chevron_right,
                    size: 14,
                    color: context.textSecondaryColor,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class HairlineDivider extends StatelessWidget {
  final double marginVertical;
  const HairlineDivider({super.key, this.marginVertical = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: marginVertical),
      height: 1,
      color: context.hairlineColor,
    );
  }
}
