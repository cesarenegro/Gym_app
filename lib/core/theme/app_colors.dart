import 'package:flutter/material.dart';

/// Kinetic Obsidian Design System Color Tokens
abstract class AppColors {
  // Canvas & Surfaces
  static const Color obsidianCore = Color(0xFF0A0A0B); // #0A0A0B Base Canvas
  static const Color background = Color(0xFF131314);
  static const Color carbonSurface1 = Color(0xFF141416); // Surface Layer 1 (Cards, Tiles)
  static const Color carbonSurface2 = Color(0xFF1B1B1E); // Surface Layer 2 (Modals, Active Cards)
  static const Color surfaceContainerHigh = Color(0xFF2A2A2B);
  static const Color surfaceContainerHighest = Color(0xFF353436);
  static const Color surfaceContainerLowest = Color(0xFF0E0E0F);

  // Hairline Dividers & Keylines
  static const Color hairline = Color(0xFF26262B); // 1px architectural border
  static const Color hairlineLight = Color(0xFF3A393A);

  // Brand Accent: Performance Volt / Acid Lime
  static const Color volt = Color(0xFFD4FF00); // Primary Accent / Action Trigger
  static const Color voltDim = Color(0xFFB0D500);
  static const Color voltContainer = Color(0xFFCAF300);
  static const Color onVolt = Color(0xFF0A0A0B); // Obsidian text on Volt

  // Typography
  static const Color textPrimary = Color(0xFFF5F5F7); // Off-white headline/high legibility
  static const Color textSecondary = Color(0xFF8E8E93); // Slate / metadata / units
  static const Color textVariant = Color(0xFFC5C9AC);

  // Status & Utility
  static const Color success = Color(0xFF30D158);
  static const Color warning = Color(0xFFFF9F0A);
  static const Color error = Color(0xFFFF453A);
  static const Color errorContainer = Color(0xFF93000A);
}
