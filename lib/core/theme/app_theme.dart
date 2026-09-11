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
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.coolBackground, // #CBCBCB
      primaryColor: AppColors.coolAccent, // #5A5A5A
      canvasColor: AppColors.coolBackground,
      cardColor: AppColors.coolSurface1, // #E5E5E5 Card chiara
      dividerColor: AppColors.coolHairline, // #D4D4D4
      colorScheme: const ColorScheme.light(
        primary: AppColors.coolAccent,
        onPrimary: AppColors.coolOnAccent, // #FFFFFF
        primaryContainer: AppColors.coolSurface2,
        onPrimaryContainer: AppColors.coolTextPrimary,
        surface: AppColors.coolSurface1,
        onSurface: AppColors.coolTextPrimary, // #2E1B0E Espresso scuro
        onSurfaceVariant: AppColors.coolTextSecondary, // #503A2B Espresso
        surfaceContainerHigh: AppColors.coolSurface2, // #F0F0F0
        error: AppColors.error,
        onError: AppColors.coolOnAccent,
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
        unselectedItemColor: AppColors.coolTextSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.coolAccent,
          foregroundColor: AppColors.coolOnAccent,
          elevation: 0,
          shape: const StadiumBorder(),
          textStyle: AppTypography.tagUppercase.copyWith(
            color: AppColors.coolOnAccent,
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
        fillColor: AppColors.coolSurface1,
        hintStyle: AppTypography.bodyDefault.copyWith(color: AppColors.coolTextSecondary),
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

/// Dynamic Theme Color Helper Extension
extension AppThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);
  bool get isCoolTheme => Theme.of(this).scaffoldBackgroundColor.value == AppColors.coolBackground.value;
  Color get appBg => Theme.of(this).scaffoldBackgroundColor;
  Color get cardBg => Theme.of(this).cardColor;
  Color get cardBg2 => Theme.of(this).colorScheme.surfaceContainerHigh;
  Color get accentColor => Theme.of(this).colorScheme.primary;
  Color get onAccentColor => Theme.of(this).colorScheme.onPrimary;
  Color get textPrimaryColor => Theme.of(this).colorScheme.onSurface;
  Color get textSecondaryColor => Theme.of(this).colorScheme.onSurfaceVariant;
  Color get hairlineColor => Theme.of(this).dividerColor;
}
