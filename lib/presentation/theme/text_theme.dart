import 'package:flutter/material.dart';

class AppTextTheme {
  static TextTheme get lightTextTheme {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 40,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      displayMedium: TextStyle(
        fontSize: 32,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      headlineLarge: TextStyle(
        fontSize: 18,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        fontSize: 16,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      headlineSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      bodyLarge: TextStyle(
        fontSize: 14,
        fontFamily: 'Inter',
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        height: 1.75,
        color: Colors.black,
      ),
      labelLarge: TextStyle(
        fontSize: 12,
        fontFamily: 'Inter',
        color: Colors.black,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }

  static TextTheme get darkTextTheme {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 40,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      displayMedium: TextStyle(
        fontSize: 32,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      headlineLarge: TextStyle(
        fontSize: 18,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        fontSize: 16,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      headlineSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontSize: 14,
        fontFamily: 'Inter',
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        height: 1.75,
        color: Colors.white,
      ),
      labelLarge: TextStyle(
        fontSize: 12,
        fontFamily: 'Inter',
        color: Colors.white,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    );
  }
}
