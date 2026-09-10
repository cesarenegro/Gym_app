import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/components/action_pill.dart';
import '../models/daily_item.dart';

class DailyImmersiveViewer extends StatelessWidget {
  final DailyItem item;

  const DailyImmersiveViewer({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.obsidianCore,
      body: Stack(
        children: [
          // Background Hero Image with Scrim
          Positioned.fill(
            child: Image.network(
              item.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: AppColors.carbonSurface2),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.obsidianCore.withOpacity(0.4),
                    AppColors.obsidianCore.withOpacity(0.7),
                    AppColors.obsidianCore.withOpacity(0.98),
                  ],
                  stops: const [0.0, 0.45, 0.8],
                ),
              ),
            ),
          ),

          // Content Area
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top App Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.obsidianCore.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: AppColors.hairline),
                        ),
                        child: Text(
                          item.category.label.toUpperCase(),
                          style: AppTypography.tagUppercase.copyWith(
                            color: AppColors.volt,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: AppColors.textPrimary, size: 24),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Editorial Content
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.carbonSurface2,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              item.durationOrMetric,
                              style: AppTypography.tagUppercase.copyWith(
                                color: AppColors.textPrimary,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            item.subtitle.toUpperCase(),
                            style: AppTypography.tagUppercase.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        item.title.toUpperCase(),
                        style: AppTypography.headlineEditorialLg.copyWith(
                          fontSize: 28,
                          height: 1.15,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        item.description,
                        style: AppTypography.bodyLead.copyWith(
                          fontSize: 14,
                          color: AppColors.textPrimary.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Bullet items / structure
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.carbonSurface1.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.hairline),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: item.bulletPoints
                              .map(
                                (pt) => Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('✦ ', style: TextStyle(color: AppColors.volt, fontSize: 12)),
                                      Expanded(
                                        child: Text(
                                          pt,
                                          style: AppTypography.bodyDefault.copyWith(
                                            fontSize: 13,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Action CTA Pill
                      ActionPill(
                        label: item.ctaLabel,
                        icon: Icons.arrow_forward,
                        onPressed: () {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppColors.carbonSurface2,
                              content: Text(
                                '${item.ctaLabel} registrato con successo.',
                                style: AppTypography.bodyDefault.copyWith(color: AppColors.volt),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
