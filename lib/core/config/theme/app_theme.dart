import 'package:flutter/material.dart';
import '../../utilities/app_colors.dart';
import '../../utilities/app_fonts.dart';

/// App theme configuration
/// 
/// Provides light and dark theme data for the application
/// Uses responsive fonts from AppFonts for better cross-device support
class AppTheme {
  // Prevent instantiation
  AppTheme._();

  /// Light theme configuration
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      
      // Color Scheme
      colorScheme: ColorScheme.light(
        primary: AppColors.primaryLight,
        primaryContainer: AppColors.primaryVariantLight,
        secondary: AppColors.secondaryLight,
        secondaryContainer: AppColors.secondaryVariantLight,
        surface: AppColors.surfaceLight,
        error: AppColors.errorLight,
        onPrimary: AppColors.white,
        onSecondary: AppColors.black,
        onSurface: AppColors.textPrimaryLight,
        onError: AppColors.white,
      ),

      // Scaffold
      scaffoldBackgroundColor: AppColors.backgroundLight,

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppFonts.styleSemibold20(context).copyWith(
          color: AppColors.white,
        ),
      ),

      // Text Theme - Using Responsive Fonts
      textTheme: TextTheme(
        // Display styles
        displayLarge: AppFonts.styleBold20(context).copyWith(
          fontSize: responsiveFontSize(context, fontSize: 32),
          color: AppColors.textPrimaryLight,
        ),
        displayMedium: AppFonts.styleBold20(context).copyWith(
          fontSize: responsiveFontSize(context, fontSize: 28),
          color: AppColors.textPrimaryLight,
        ),
        displaySmall: AppFonts.styleSemibold24(context).copyWith(
          color: AppColors.textPrimaryLight,
        ),
        
        // Headline styles
        headlineLarge: AppFonts.styleSemibold20(context).copyWith(
          color: AppColors.textPrimaryLight,
        ),
        headlineMedium: AppFonts.styleSemibold18(context).copyWith(
          color: AppColors.textPrimaryLight,
        ),
        headlineSmall: AppFonts.styleSemibold16(context).copyWith(
          color: AppColors.textPrimaryLight,
        ),
        
        // Body styles
        bodyLarge: AppFonts.styleRegular16(context).copyWith(
          color: AppColors.textPrimaryLight,
        ),
        bodyMedium: AppFonts.styleRegular14(context).copyWith(
          color: AppColors.textSecondaryLight,
        ),
        bodySmall: AppFonts.styleRegular12(context).copyWith(
          color: AppColors.textSecondaryLight,
        ),
        
        // Label styles
        labelLarge: AppFonts.styleMedium16(context).copyWith(
          color: AppColors.textPrimaryLight,
        ),
        labelMedium: AppFonts.styleMedium16(context).copyWith(
          fontSize: responsiveFontSize(context, fontSize: 14),
          color: AppColors.textSecondaryLight,
        ),
        labelSmall: AppFonts.styleRegular12(context).copyWith(
          color: AppColors.textSecondaryLight,
        ),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerLight,
        thickness: 1,
      ),

      // Card
      cardTheme: const CardThemeData(
        color: AppColors.surfaceLight,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceLight,
        labelStyle: AppFonts.styleRegular14(context).copyWith(
          color: AppColors.textSecondaryLight,
        ),
        hintStyle: AppFonts.styleRegular14(context).copyWith(
          color: AppColors.textSecondaryLight,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.dividerLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.dividerLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
        ),
      ),

      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: AppColors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: AppFonts.styleMedium16(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  /// Dark theme configuration
  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      
      // Color Scheme
      colorScheme: ColorScheme.dark(
        primary: AppColors.primaryDark,
        primaryContainer: AppColors.primaryVariantDark,
        secondary: AppColors.secondaryDark,
        secondaryContainer: AppColors.secondaryVariantDark,
        surface: AppColors.surfaceDark,
        error: AppColors.errorDark,
        onPrimary: AppColors.black,
        onSecondary: AppColors.black,
        onSurface: AppColors.textPrimaryDark,
        onError: AppColors.black,
      ),

      // Scaffold
      scaffoldBackgroundColor: AppColors.backgroundDark,

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppFonts.styleSemibold20(context).copyWith(
          color: AppColors.white,
        ),
      ),

      // Text Theme - Using Responsive Fonts
      textTheme: TextTheme(
        // Display styles
        displayLarge: AppFonts.styleBold20(context).copyWith(
          fontSize: responsiveFontSize(context, fontSize: 32),
          color: AppColors.textPrimaryDark,
        ),
        displayMedium: AppFonts.styleBold20(context).copyWith(
          fontSize: responsiveFontSize(context, fontSize: 28),
          color: AppColors.textPrimaryDark,
        ),
        displaySmall: AppFonts.styleSemibold24(context).copyWith(
          color: AppColors.textPrimaryDark,
        ),
        
        // Headline styles
        headlineLarge: AppFonts.styleSemibold20(context).copyWith(
          color: AppColors.textPrimaryDark,
        ),
        headlineMedium: AppFonts.styleSemibold18(context).copyWith(
          color: AppColors.textPrimaryDark,
        ),
        headlineSmall: AppFonts.styleSemibold16(context).copyWith(
          color: AppColors.textPrimaryDark,
        ),
        
        // Body styles
        bodyLarge: AppFonts.styleRegular16(context).copyWith(
          color: AppColors.textPrimaryDark,
        ),
        bodyMedium: AppFonts.styleRegular14(context).copyWith(
          color: AppColors.textSecondaryDark,
        ),
        bodySmall: AppFonts.styleRegular12(context).copyWith(
          color: AppColors.textSecondaryDark,
        ),
        
        // Label styles
        labelLarge: AppFonts.styleMedium16(context).copyWith(
          color: AppColors.textPrimaryDark,
        ),
        labelMedium: AppFonts.styleMedium16(context).copyWith(
          fontSize: responsiveFontSize(context, fontSize: 14),
          color: AppColors.textSecondaryDark,
        ),
        labelSmall: AppFonts.styleRegular12(context).copyWith(
          color: AppColors.textSecondaryDark,
        ),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerDark,
        thickness: 1,
      ),

      // Card
      cardTheme: const CardThemeData(
        color: AppColors.surfaceDark,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceDark,
        labelStyle: AppFonts.styleRegular14(context).copyWith(
          color: AppColors.textSecondaryDark,
        ),
        hintStyle: AppFonts.styleRegular14(context).copyWith(
          color: AppColors.textSecondaryDark,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.dividerDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.dividerDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primaryDark, width: 2),
        ),
      ),

      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: AppColors.black,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: AppFonts.styleMedium16(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

