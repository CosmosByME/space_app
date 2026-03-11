import 'package:flutter/material.dart';
import 'package:space_app/presentation/theme/colors.dart';
import 'package:space_app/presentation/theme/sizes.dart';
import 'package:space_app/presentation/theme/text_theme.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme(
        surface: Colors.white,
        onSurface: AppColors.neutralB400,
        brightness: Brightness.light,
        primary: AppColors.primaryB900,
        onPrimary: AppColors.neutralB400,
        secondary: AppColors.primaryB900,
        onSecondary: AppColors.neutralB400,
        error: Colors.red,
        onError: AppColors.neutralB400,
        surfaceTint: AppColors.neutralB400,
      ),
      brightness: Brightness.light,
      primaryColor: AppColors.primaryB900,
      scaffoldBackgroundColor: AppColors.primaryB100,
      textTheme: AppTextTheme.lightTextTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryB900,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radius12),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spacing24,
            vertical: AppSizes.spacing12,
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.neutralW400,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextTheme.lightTextTheme.headlineSmall?.copyWith(
          color: AppColors.neutralW400,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: ColorScheme(
        surface: AppColors.neutralB900,
        onSurface: AppColors.neutralW400,
        brightness: Brightness.dark,
        primary: AppColors.primaryB900,
        onPrimary: AppColors.neutralW400,
        secondary: AppColors.primaryB900,
        onSecondary: AppColors.neutralW400,
        error: Colors.red,
        onError: AppColors.neutralW400,
        surfaceTint: AppColors.neutralW400,
      ),
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryB900,
      scaffoldBackgroundColor: AppColors.neutralB800,
      textTheme: AppTextTheme.darkTextTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryB900,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radius12),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spacing24,
            vertical: AppSizes.spacing12,
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.neutralB800,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextTheme.darkTextTheme.headlineSmall?.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}
