import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

enum AppThemeMode {
  obsidian,
  cool,
}

class AppTheme {
  static ThemeData getTheme(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.cool:
        return coolTheme;
      case AppThemeMode.obsidian:
        return darkTheme;
    }
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.obsidianCore,
      primaryColor: AppColors.volt,
      canvasColor: AppColors.obsidianCore,
      cardColor: AppColors.carbonSurface1,
      dividerColor: AppColors.hairline,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.volt,
        onPrimary: AppColors.onVolt,
        primaryContainer: AppColors.voltContainer,
        onPrimaryContainer: AppColors.onVolt,
        surface: AppColors.carbonSurface1,
        onSurface: AppColors.textPrimary,
        surfaceContainerHigh: AppColors.carbonSurface2,
        error: AppColors.error,
        onError: AppColors.obsidianCore,
        outline: AppColors.hairline,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.obsidianCore,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.obsidianCore,
        selectedItemColor: AppColors.volt,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.volt,
          foregroundColor: AppColors.onVolt,
          elevation: 0,
          shape: const StadiumBorder(),
          textStyle: AppTypography.tagUppercase.copyWith(
            color: AppColors.onVolt,
            fontWeight: FontWeight.w700,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          side: const BorderSide(color: AppColors.hairline, width: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          textStyle: AppTypography.tagUppercase.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.carbonSurface1,
        hintStyle: AppTypography.bodyDefault.copyWith(color: AppColors.textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.hairline, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.hairline, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.volt, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  static ThemeData get coolTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.coolBackground, // #CBCBCB
      primaryColor: AppColors.coolAccent, // #5A5A5A
      canvasColor: AppColors.coolBackground,
      cardColor: AppColors.coolAccent,
      dividerColor: AppColors.coolHairline,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.coolAccent,
        onPrimary: AppColors.coolTextPrimary, // #F2F2F2
        primaryContainer: AppColors.coolAccent,
        onPrimaryContainer: AppColors.coolTextPrimary,
        surface: AppColors.coolAccent,
        onSurface: AppColors.coolTextPrimary, // #F2F2F2
        surfaceContainerHigh: AppColors.coolSurface2,
        error: AppColors.error,
        onError: AppColors.coolTextPrimary,
        outline: AppColors.coolHairline,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.coolBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.coolTextPrimary),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.coolBackground,
        selectedItemColor: AppColors.coolAccent,
        unselectedItemColor: AppColors.coolTextDark,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.coolAccent,
          foregroundColor: AppColors.coolTextPrimary,
          elevation: 0,
          shape: const StadiumBorder(),
          textStyle: AppTypography.tagUppercase.copyWith(
            color: AppColors.coolTextPrimary,
            fontWeight: FontWeight.w700,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.coolTextPrimary,
          side: const BorderSide(color: AppColors.coolHairline, width: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          textStyle: AppTypography.tagUppercase.copyWith(
            color: AppColors.coolTextPrimary,
            fontWeight: FontWeight.w700,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.coolAccent,
        hintStyle: AppTypography.bodyDefault.copyWith(color: AppColors.coolTextPrimary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.coolHairline, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.coolHairline, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.coolAccent, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
