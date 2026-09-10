import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/components/action_pill.dart';
import '../../../core/components/secondary_button.dart';

class ModerationSheet extends StatefulWidget {
  final String contentId;
  final String authorName;
  final VoidCallback onReportSubmitted;
  final VoidCallback onUserBlocked;

  const ModerationSheet({
    super.key,
    required this.contentId,
    required this.authorName,
    required this.onReportSubmitted,
    required this.onUserBlocked,
  });

  @override
  State<ModerationSheet> createState() => _ModerationSheetState();
}

class _ModerationSheetState extends State<ModerationSheet> {
  String? _selectedReason;
  final List<String> _reasons = [
    'Contenuto offensivo o molesto',
    'Spam o pubblicità non autorizzata',
    'Informazioni ingannevoli o pericolose',
    'Violazione delle linee guida della community',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.carbonSurface1,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        border: Border(top: BorderSide(color: AppColors.hairline)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'MODERAZIONE & SICUREZZA',
                  style: AppTypography.tagUppercase.copyWith(color: AppColors.volt),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.textSecondary, size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Segnala o Blocca',
              style: AppTypography.headlineEditorialSm.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 4),
            Text(
              'Seleziona il motivo della segnalazione per inviarlo al team di moderazione della piattaforma:',
              style: AppTypography.bodyCompact,
            ),
            const SizedBox(height: 16),
            ..._reasons.map((reason) {
              final isSelected = reason == _selectedReason;
              return GestureDetector(
                onTap: () => setState(() => _selectedReason = reason),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.carbonSurface2 : Colors.transparent,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: isSelected ? AppColors.volt : AppColors.hairline,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                        size: 16,
                        color: isSelected ? AppColors.volt : AppColors.textSecondary,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          reason,
                          style: AppTypography.bodyDefault.copyWith(
                            color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    label: 'Blocca Autore',
                    icon: Icons.block,
                    textColor: AppColors.error,
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.onUserBlocked();
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ActionPill(
                    label: 'Invia Segnalazione',
                    onPressed: _selectedReason == null
                        ? null
                        : () {
                            Navigator.of(context).pop();
                            widget.onReportSubmitted();
                          },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
