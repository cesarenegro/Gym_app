import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/components/action_pill.dart';
import '../models/daily_item.dart';

class DailyImmersiveViewer extends StatelessWidget {
  final DailyItem item;

  const DailyImmersiveViewer({super.key, required this.item});

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.obsidianCore,
      body: Stack(
        children: [
          // Background Hero Image with Scrim
          Positioned.fill(
            child: _buildImage(item.imageUrl),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.obsidianCore.withValues(alpha: 0.3),
                    AppColors.obsidianCore.withValues(alpha: 0.75),
                    AppColors.obsidianCore.withValues(alpha: 0.98),
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
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.obsidianCore.withValues(alpha: 0.85),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: AppColors.hairline),
                        ),
                        child: Text(
                          'RICETTA & PASTO',
                          style: AppTypography.tagUppercase.copyWith(
                            color: AppColors.volt,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: AppColors.textPrimary, size: 26),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 120), // Spazio per far respirare l'immagine

                        // Meta Row
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.carbonSurface2,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '${item.totalTimeLabel} · ${item.difficulty}',
                                style: AppTypography.tagUppercase.copyWith(
                                  color: AppColors.textPrimary,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'PORZIONI: ${item.servings}',
                              style: AppTypography.tagUppercase.copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 11,
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
                        const SizedBox(height: 8),
                        Text(
                          item.subtitle,
                          style: AppTypography.bodyLead.copyWith(
                            fontSize: 16,
                            color: AppColors.textPrimary.withValues(alpha: 0.9),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Colored Tags list
                        if (item.tags.isNotEmpty) ...[
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: item.tags.map((t) {
                              Color tagBg = AppColors.carbonSurface2;
                              Color textColor = AppColors.textPrimary;
                              if (t.contains('SLIM')) {
                                tagBg = const Color(0xFFD7F75B);
                                textColor = Colors.black;
                              } else if (t.contains('PROTEIN')) {
                                tagBg = const Color(0xFF80CFFF);
                                textColor = Colors.black;
                              } else if (t.contains('POWER')) {
                                tagBg = const Color(0xFFFFC76A);
                                textColor = Colors.black;
                              } else if (t.contains('TESTOSTERONE')) {
                                tagBg = const Color(0xFFC8B6FF);
                                textColor = Colors.black;
                              } else if (t.contains('DETOX')) {
                                tagBg = const Color(0xFF86DEC4);
                                textColor = Colors.black;
                              }

                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: tagBg,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  t,
                                  style: AppTypography.tagUppercase.copyWith(
                                    color: textColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 16),
                        ],

                        // MANDATORY COMPLIANCE NOTE FOR TESTOSTERONE* & DETOX*
                        if (item.tagNote != null && item.tagNote!.isNotEmpty) ...[
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: AppColors.obsidianCore,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: const Color(0xFFFFC76A), width: 1),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.info_outline, color: Color(0xFFFFC76A), size: 18),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    item.tagNote!,
                                    style: AppTypography.bodyCompact.copyWith(
                                      color: AppColors.textPrimary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],

                        // Ingredienti Box
                        if (item.ingredients.isNotEmpty) ...[
                          Text('INGREDIENTI', style: AppTypography.tagUppercase.copyWith(fontSize: 12, color: AppColors.volt)),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.carbonSurface1.withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.hairline),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: item.ingredients
                                  .map(
                                    (ing) => Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4),
                                      child: Row(
                                        children: [
                                          const Text('• ', style: TextStyle(color: AppColors.volt, fontSize: 14, fontWeight: FontWeight.bold)),
                                          Expanded(
                                            child: Text(
                                              ing,
                                              style: AppTypography.bodyDefault.copyWith(fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],

                        // Passaggi Preparazione
                        if (item.steps.isNotEmpty) ...[
                          Text('PREPARAZIONE', style: AppTypography.tagUppercase.copyWith(fontSize: 12, color: AppColors.volt)),
                          const SizedBox(height: 10),
                          Column(
                            children: item.steps.asMap().entries.map((entry) {
                              final idx = entry.key + 1;
                              final step = entry.value;
                              return Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColors.carbonSurface1,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: AppColors.hairline),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: AppColors.volt,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '$idx',
                                          style: AppTypography.tagUppercase.copyWith(
                                            color: AppColors.onVolt,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        step,
                                        style: AppTypography.bodyDefault.copyWith(fontSize: 14, height: 1.4),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 24),
                        ],

                        // Action CTA Pill
                        ActionPill(
                          label: 'Aggiungi al Diario Nutrizione',
                          icon: Icons.add,
                          onPressed: () {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: AppColors.carbonSurface2,
                                content: Text(
                                  '${item.title} aggiunta al tuo diario di oggi!',
                                  style: AppTypography.bodyDefault.copyWith(color: AppColors.volt),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
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
