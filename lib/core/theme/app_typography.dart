import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Kinetic Obsidian Typography Rules:
/// Headlines, Metrics, Labels & Index Tags -> Space Grotesk
/// Body, Descriptions, Form Controls -> Inter
abstract class AppTypography {
  // Display Hero
  static TextStyle get displayHero => GoogleFonts.spaceGrotesk(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        height: 52 / 48,
        letterSpacing: -0.04 * 48,
        color: AppColors.textPrimary,
      );

  static TextStyle get displayHeroMobile => GoogleFonts.spaceGrotesk(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 38 / 32,
        letterSpacing: -0.03 * 32,
        color: AppColors.textPrimary,
      );

  // Headlines
  static TextStyle get headlineEditorialLg => GoogleFonts.spaceGrotesk(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        height: 30 / 26,
        letterSpacing: -0.02 * 26,
        color: AppColors.textPrimary,
      );

  static TextStyle get headlineEditorialMd => GoogleFonts.spaceGrotesk(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 26 / 20,
        letterSpacing: -0.01 * 20,
        color: AppColors.textPrimary,
      );

  static TextStyle get headlineEditorialSm => GoogleFonts.spaceGrotesk(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 22 / 16,
        letterSpacing: 0,
        color: AppColors.textPrimary,
      );

  // Numerals & Telemetry (Tabular figures enabled)
  static TextStyle get metricNumeralLg => GoogleFonts.spaceGrotesk(
        fontSize: 38,
        fontWeight: FontWeight.w700,
        height: 42 / 38,
        letterSpacing: -0.03 * 38,
        color: AppColors.textPrimary,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  static TextStyle get metricNumeralMd => GoogleFonts.spaceGrotesk(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        height: 26 / 22,
        letterSpacing: -0.02 * 22,
        color: AppColors.textPrimary,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  // Uppercase Index Tags
  static TextStyle get tagUppercase => GoogleFonts.spaceGrotesk(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        height: 14 / 11,
        letterSpacing: 1.32, // 0.12em
        color: AppColors.textSecondary,
      );

  static TextStyle get tabLabel => GoogleFonts.spaceGrotesk(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        height: 12 / 10,
        letterSpacing: 1.0, // 0.10em
      );

  // Body text (Inter)
  static TextStyle get bodyLead => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 26 / 16,
        letterSpacing: -0.01 * 16,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodyDefault => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 22 / 14,
        letterSpacing: 0,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodyCompact => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 18 / 12,
        letterSpacing: 0.12,
        color: AppColors.textSecondary,
      );
}
