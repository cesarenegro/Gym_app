import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/state/gym_state_providers.dart';
import '../models/daily_item.dart';
import 'daily_immersive_viewer.dart';

class DailiesCatalogScreen extends ConsumerStatefulWidget {
  const DailiesCatalogScreen({super.key});

  @override
  ConsumerState<DailiesCatalogScreen> createState() => _DailiesCatalogScreenState();
}

class _DailiesCatalogScreenState extends ConsumerState<DailiesCatalogScreen> {
  String _selectedCategory = 'Tutti';
  final List<String> _categories = ['Tutti', 'Ricette', 'WOD', 'Tip', 'Sfide'];

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
    final allDailies = ref.watch(dailiesProvider);

    final filteredDailies = _selectedCategory == 'Tutti'
        ? allDailies
        : allDailies.where((d) {
            if (_selectedCategory == 'Ricette') return d.category == DailyCategory.mealOfDay;
            if (_selectedCategory == 'WOD') return d.category == DailyCategory.workoutOfDay;
            if (_selectedCategory == 'Tip') return d.category == DailyCategory.trainerTip;
            if (_selectedCategory == 'Sfide') return d.category == DailyCategory.challengeOfDay;
            return true;
          }).toList();

    return Scaffold(
      backgroundColor: AppColors.obsidianCore,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ARCHIVIO COMPLETO', style: AppTypography.tagUppercase.copyWith(fontSize: 11)),
            Text('NOTIZIE & DAILIES (${allDailies.length})', style: AppTypography.headlineEditorialSm.copyWith(fontSize: 18)),
          ],
        ),
      ),
      body: Column(
        children: [
          // Filter Chips
          Container(
            height: 48,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, idx) {
                final cat = _categories[idx];
                final isSelected = cat == _selectedCategory;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = cat),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.volt : AppColors.carbonSurface1,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: isSelected ? AppColors.volt : AppColors.hairline),
                    ),
                    child: Center(
                      child: Text(
                        cat.toUpperCase(),
                        style: AppTypography.tagUppercase.copyWith(
                          color: isSelected ? AppColors.onVolt : AppColors.textPrimary,
                          fontSize: 11,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Grid of 20 Dailies
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.82,
              ),
              itemCount: filteredDailies.length,
              itemBuilder: (context, index) {
                final daily = filteredDailies[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => DailyImmersiveViewer(item: daily)),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.carbonSurface1,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.hairline),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: _buildImage(daily.imageUrl),
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  AppColors.obsidianCore.withValues(alpha: 0.95),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: AppColors.obsidianCore.withValues(alpha: 0.85),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      daily.category.tagCode,
                                      style: AppTypography.tagUppercase.copyWith(color: AppColors.volt, fontSize: 10),
                                    ),
                                  ),
                                  if (daily.totalTimeLabel.isNotEmpty)
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: AppColors.carbonSurface2.withValues(alpha: 0.85),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        daily.totalTimeLabel,
                                        style: AppTypography.tagUppercase.copyWith(color: AppColors.textPrimary, fontSize: 9),
                                      ),
                                    ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    daily.title.toUpperCase(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.headlineEditorialSm.copyWith(fontSize: 14, height: 1.2),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    daily.subtitle,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.bodyCompact.copyWith(fontSize: 11, color: AppColors.textSecondary),
                                  ),
                                ],
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
        ],
      ),
    );
  }
}
