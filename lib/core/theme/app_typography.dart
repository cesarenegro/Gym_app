import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Regole Tipografiche Kinetic Obsidian (Dimensioni incrementate per leggibilità su Mobile/Chrome):
/// Headlines, Metriche, Etichette e Tag -> Space Grotesk
/// Corpo testo, Descrizioni, Controlli form -> Inter
abstract class AppTypography {
  // Display Hero
  static TextStyle get displayHero => GoogleFonts.spaceGrotesk(
        fontSize: 52,
        fontWeight: FontWeight.w700,
        height: 56 / 52,
        letterSpacing: -0.04 * 52,
        color: AppColors.textPrimary,
      );

  static TextStyle get displayHeroMobile => GoogleFonts.spaceGrotesk(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        height: 42 / 36,
        letterSpacing: -0.03 * 36,
        color: AppColors.textPrimary,
      );

  // Headlines
  static TextStyle get headlineEditorialLg => GoogleFonts.spaceGrotesk(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 34 / 28,
        letterSpacing: -0.02 * 28,
        color: AppColors.textPrimary,
      );

  static TextStyle get headlineEditorialMd => GoogleFonts.spaceGrotesk(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        height: 28 / 22,
        letterSpacing: -0.01 * 22,
        color: AppColors.textPrimary,
      );

  static TextStyle get headlineEditorialSm => GoogleFonts.spaceGrotesk(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 24 / 18,
        letterSpacing: 0,
        color: AppColors.textPrimary,
      );

  // Numerici e Telemetria
  static TextStyle get metricNumeralLg => GoogleFonts.spaceGrotesk(
        fontSize: 42,
        fontWeight: FontWeight.w700,
        height: 46 / 42,
        letterSpacing: -0.03 * 42,
        color: AppColors.textPrimary,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  static TextStyle get metricNumeralMd => GoogleFonts.spaceGrotesk(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 28 / 24,
        letterSpacing: -0.02 * 24,
        color: AppColors.textPrimary,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  // Tag in maiuscolo ed Etichette
  static TextStyle get tagUppercase => GoogleFonts.spaceGrotesk(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        height: 16 / 13,
        letterSpacing: 1.1,
        color: AppColors.textSecondary,
      );

  static TextStyle get tabLabel => GoogleFonts.spaceGrotesk(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        height: 14 / 11,
        letterSpacing: 0.8,
      );

  // Corpo del testo (Inter)
  static TextStyle get bodyLead => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 28 / 18,
        letterSpacing: -0.01 * 18,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodyDefault => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 24 / 16,
        letterSpacing: 0,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodyCompact => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 20 / 14,
        letterSpacing: 0.1,
        color: AppColors.textSecondary,
      );
}
