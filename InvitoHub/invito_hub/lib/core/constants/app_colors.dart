import 'package:flutter/material.dart';

class AppColors {
  // Brand colors (Purple/Pink gradient theme)
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryDark = Color(0xFF3F3D56);
  static const Color secondary = Color(0xFFFF6584);
  static const Color accent = Color(0xFF00D2FF);

  // Backgrounds
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceLight = Colors.white;
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // Text
  static const Color textPrimaryLight = Color(0xFF2D3142);
  static const Color textSecondaryLight = Color(0xFF9094A6);
  static const Color textPrimaryDark = Color(0xFFF4F5F7);
  static const Color textSecondaryDark = Color(0xFFA1A4B2);

  // Status
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFC107);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [Color(0xFF2C3E50), Color(0xFF000000)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
