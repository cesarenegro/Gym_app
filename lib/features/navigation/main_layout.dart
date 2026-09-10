import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/components/floating_ai_pill.dart';
import '../home/presentation/home_screen.dart';
import '../training/presentation/training_screen.dart';
import '../courses/presentation/courses_screen.dart';
import '../community/presentation/community_screen.dart';
import '../profile/presentation/profile_screen.dart';
import '../ai/presentation/gym_ai_modal.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    TrainingScreen(),
    CoursesScreen(),
    CommunityScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.obsidianCore,
      body: Stack(
        children: [
          // Indexed Stack for fast navigation and persistent state
          IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),

          // Floating AI Trigger Button (Positioned bottom right above tab bar)
          Positioned(
            right: 20,
            bottom: 84,
            child: FloatingAiPill(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => const GymAiModal(),
                );
              },
            ),
          ),
        ],
      ),

      // 5-Tab Navigation Bar conforming to Kinetic Obsidian specs
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.obsidianCore,
          border: Border(top: BorderSide(color: AppColors.hairline, width: 1)),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 64,
            child: Row(
              children: [
                _buildNavItem(0, Icons.home_outlined, Icons.home, 'HOME'),
                _buildNavItem(1, Icons.fitness_center_outlined, Icons.fitness_center, 'TRAIN'),
                _buildNavItem(2, Icons.calendar_month_outlined, Icons.calendar_month, 'BOOK'),
                _buildNavItem(3, Icons.people_outline, Icons.people, 'COMMUNITY'),
                _buildNavItem(4, Icons.person_outline, Icons.person, 'PROFILE'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData unselectedIcon, IconData selectedIcon, String label) {
    final isSelected = _currentIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _currentIndex = index),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSelected ? selectedIcon : unselectedIcon,
                size: 20,
                color: isSelected ? AppColors.volt : AppColors.textSecondary,
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: AppTypography.tabLabel.copyWith(
                  color: isSelected ? AppColors.volt : AppColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 9,
                ),
              ),
              const SizedBox(height: 2),
              // Active Indicator Dot
              Container(
                width: 3,
                height: 3,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.volt : Colors.transparent,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
