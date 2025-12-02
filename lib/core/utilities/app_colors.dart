import 'package:flutter/material.dart';

/// App-wide color definitions
/// 
/// This class contains all color constants used throughout the application.
/// Colors are organized by theme (light/dark) and usage (primary, secondary, etc.)
class AppColors {
  // Prevent instantiation
  AppColors._();

  // ============================================
  // Primary Colors
  // ============================================
  static const Color primaryLight = Color(0xFFFF6B00); // Orange from image
  static const Color primaryDark = Color(0xFFFF6B00);
  
  static const Color primaryVariantLight = Color(0xFFFF8F40);
  static const Color primaryVariantDark = Color(0xFFFF8F40);

  static const Color orangeLight = Color(0xFFFFF2E9); // Light orange background

  // ============================================
  // Secondary Colors
  // ============================================
  static const Color secondaryLight = Color(0xFF03DAC6);
  static const Color secondaryDark = Color(0xFF03DAC6);
  
  static const Color secondaryVariantLight = Color(0xFF018786);
  static const Color secondaryVariantDark = Color(0xFF03DAC6);

  // ============================================
  // Background Colors
  // ============================================
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF121212);
  
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // ============================================
  // Text Colors
  // ============================================
  static const Color textPrimaryLight = Color(0xFF000000);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  
  static const Color textSecondaryLight = Color(0xFF757575);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);

  // ============================================
  // Error Colors
  // ============================================
  static const Color errorLight = Color(0xFFB00020);
  static const Color errorDark = Color(0xFFCF6679);

  // ============================================
  // Success Colors
  // ============================================
  static const Color success = Color(0xFF4CAF50);
  static const Color successDark = Color(0xFF81C784);

  // ============================================
  // Warning Colors
  // ============================================
  static const Color warning = Color(0xFFFFC107);
  static const Color warningDark = Color(0xFFFFD54F);

  // ============================================
  // Info Colors
  // ============================================
  static const Color info = Color(0xFF2196F3);
  static const Color infoDark = Color(0xFF64B5F6);

  // ============================================
  // Divider Colors
  // ============================================
  static const Color dividerLight = Color(0xFFE0E0E0);
  static const Color dividerDark = Color(0xFF2C2C2C);

  // ============================================
  // Disabled Colors
  // ============================================
  static const Color disabledLight = Color(0xFFBDBDBD);
  static const Color disabledDark = Color(0xFF616161);

  // ============================================
  // Transparent
  // ============================================
  static const Color transparent = Colors.transparent;

  // ============================================
  // Common Colors
  // ============================================
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
}
