import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/components/action_pill.dart';
import '../../../core/state/gym_state_providers.dart';
import '../models/course_model.dart';

class CoursesScreen extends ConsumerStatefulWidget {
  const CoursesScreen({super.key});

  @override
  ConsumerState<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends ConsumerState<CoursesScreen> {
  String _selectedCategory = 'Tutti';
  final List<String> _categories = ['Tutti', 'Funzionale', 'Mobilità', 'Combat', 'Postura'];

  @override
  Widget build(BuildContext context) {
    final allCourses = ref.watch(coursesProvider);
    final filteredCourses = _selectedCategory == 'Tutti'
        ? allCourses
        : allCourses.where((c) => c.category == _selectedCategory).toList();

    return Scaffold(
      backgroundColor: AppColors.obsidianCore,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('PALINSESTO CORSI', style: AppTypography.tagUppercase.copyWith(fontSize: 11)),
            Text('PRENOTAZIONE CORSI', style: AppTypography.headlineEditorialSm.copyWith(fontSize: 18)),
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

          // Course Session List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: filteredCourses.length,
              separatorBuilder: (_, __) => const SizedBox(height: 18),
              itemBuilder: (context, idx) {
                final session = filteredCourses[idx];
                return _buildCourseCard(session);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(CourseSession session) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.carbonSurface1,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.hairline),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Image with Gradient
          Stack(
            children: [
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(session.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 160,
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
              Positioned(
                top: 14,
                left: 14,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.obsidianCore.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    session.category.toUpperCase(),
                    style: AppTypography.tagUppercase.copyWith(color: AppColors.volt, fontSize: 11),
                  ),
                ),
              ),
              Positioned(
                top: 14,
                right: 14,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: session.isFull ? AppColors.errorContainer : AppColors.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    session.isFull ? 'TUTTO ESAURITO' : '${session.spotsRemaining} POSTI RIMASTI',
                    style: AppTypography.tagUppercase.copyWith(
                      color: session.isFull ? AppColors.textPrimary : AppColors.volt,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 14,
                left: 14,
                right: 14,
                child: Text(
                  session.courseName.toUpperCase(),
                  style: AppTypography.headlineEditorialSm.copyWith(fontSize: 20),
                ),
              ),
            ],
          ),

          // Details Body
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.schedule, size: 16, color: AppColors.textSecondary),
                        const SizedBox(width: 6),
                        Text('Oggi · ${session.durationMinutes} min', style: AppTypography.bodyDefault),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.person_outline, size: 16, color: AppColors.textSecondary),
                        const SizedBox(width: 6),
                        Text(session.trainerName, style: AppTypography.bodyDefault),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.room_outlined, size: 16, color: AppColors.textSecondary),
                        const SizedBox(width: 6),
                        Text(session.room, style: AppTypography.bodyDefault),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(session.description, style: AppTypography.bodyDefault.copyWith(color: AppColors.textSecondary)),
                const SizedBox(height: 18),

                // Booking Button with dynamic states
                if (session.isBookedByUser)
                  ActionPill(
                    label: 'Annulla Prenotazione',
                    isSecondary: true,
                    onPressed: () {
                      ref.read(coursesProvider.notifier).bookSession(session.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Prenotazione annullata.')),
                      );
                    },
                  )
                else if (session.isWaitlistedByUser)
                  ActionPill(
                    label: 'In Lista d Attesa (Posizione #1)',
                    isSecondary: true,
                    onPressed: () {
                      ref.read(coursesProvider.notifier).cancelWaitlist(session.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Rimosso dalla lista d attesa.')),
                      );
                    },
                  )
                else if (session.isFull)
                  ActionPill(
                    label: 'Iscriviti alla Lista d Attesa',
                    icon: Icons.hourglass_top,
                    onPressed: () {
                      ref.read(coursesProvider.notifier).bookSession(session.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Ti sei iscritto alla lista d attesa per questa sessione!')),
                      );
                    },
                  )
                else
                  ActionPill(
                    label: 'Prenota Posto',
                    icon: Icons.check,
                    onPressed: () {
                      ref.read(coursesProvider.notifier).bookSession(session.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: AppColors.carbonSurface2,
                          content: Text(
                            'Prenotazione confermata per ${session.courseName}!',
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
    );
  }
}
