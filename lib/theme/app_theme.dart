import 'package:flutter/material.dart';

/// Matches BoilerplateApp theme.css - primary #ab1e23, foreground #2B2D42
class AppColors {
  static const Color background = Color(0xFFFFFFFF);
  static const Color foreground = Color(0xFF2B2D42);
  static const Color card = Color(0xFFFFFFFF);
  static const Color cardForeground = Color(0xFF2B2D42);
  static const Color primary = Color(0xFFAB1E23);
  static const Color primaryForeground = Color(0xFFFFFFFF);
  static const Color secondary = Color(0xFF2B2D42);
  static const Color secondaryForeground = Color(0xFFFFFFFF);
  static const Color muted = Color(0xFFF5F5F5);
  static const Color mutedForeground = Color(0xFF6B6D7F);
  static const Color accent = Color(0xFFF0F0F2);
  static const Color accentForeground = Color(0xFF2B2D42);
  static const Color destructive = Color(0xFFDC2626);
  static const Color destructiveForeground = Color(0xFFFFFFFF);
  static const Color border = Color(0x1A2B2D42); // rgba(43,45,66,0.1)
  static const Color inputBackground = Color(0xFFF8F8FA);
  static const Color switchBackground = Color(0xFFD1D1D6);
  static const Color ring = Color(0xFFAB1E23);
  static const Color chart1 = Color(0xFFAB1E23);
  static const Color chart2 = Color(0xFF2B2D42);
  static const Color chart4 = Color(0xFFE8535A);
  static const Color chart5 = Color(0xFF3D3F57);
  static const Color greenSuccess = Color(0xFF16A34A);
  static const Color greenSuccessBg = Color(0xFFF0FDF4);
  static const Color yellowWarning = Color(0xFFCA8A04);
  static const Color yellowWarningBg = Color(0xFFFEF9C3);
}

class AppTheme {
  static const double radiusSm = 8.0;
  static const double radiusMd = 10.0;
  static const double radiusLg = 12.0; // 0.75rem
  static const double radiusXl = 16.0;

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        surface: AppColors.background,
        onSurface: AppColors.foreground,
        primary: AppColors.primary,
        onPrimary: AppColors.primaryForeground,
        secondary: AppColors.secondary,
        onSecondary: AppColors.secondaryForeground,
        error: AppColors.destructive,
        outline: AppColors.border,
      ),
      scaffoldBackgroundColor: AppColors.background,
      cardTheme: CardTheme(
        color: AppColors.card,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg * 1.5),
          side: const BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputBackground,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(radiusLg)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          borderSide: const BorderSide(color: AppColors.ring, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: AppColors.foreground),
        headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        bodyMedium: TextStyle(fontSize: 14),
        labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}
