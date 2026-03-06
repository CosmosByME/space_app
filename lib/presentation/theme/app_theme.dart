import 'package:flutter/material.dart';
import 'package:space_app/presentation/theme/colors.dart';
import 'package:space_app/presentation/theme/sizes.dart';
import 'package:space_app/presentation/theme/text_theme.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
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
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryB900,
      scaffoldBackgroundColor: AppColors.neutralB900,
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
