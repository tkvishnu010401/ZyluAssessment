import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Theme Colors
  static const Color primary = Color(0xFF1E3A8A); // Deep Slate Blue
  static const Color primaryLight = Color(0xFF3B82F6);
  static const Color primaryBackground = Color(0xFFF1F5F9);
  static const Color white = Colors.white;

  // -------------------------------------------------------------
  // GREEN FLAG HIGHLIGHT COLORS (For Employees Active & > 5 Years)
  // -------------------------------------------------------------
  static const Color greenFlag = Color(0xFF15803D);       // Forest Green
  static const Color greenFlagLight = Color(0xFFDCFCE7);  // Soft Emerald Background
  static const Color greenFlagBorder = Color(0xFF22C55E); // Bright Emerald Border
  static const Color greenFlagBadge = Color(0xFF166534);  // Dark Emerald Text
  static const Color greenFlagShadow = Color(0x3322C55E); // Green Elevation Tint

  // Status Badge Colors
  static const Color statusActive = Color(0xFF0284C7);
  static const Color statusActiveBg = Color(0xFFE0F2FE);
  static const Color statusInactive = Color(0xFF64748B);
  static const Color statusInactiveBg = Color(0xFFF1F5F9);

  // Neutral Colors
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color cardBorder = Color(0xFFE2E8F0);
  static const Color cardBackground = Colors.white;
  static const Color inputBackground = Color(0xFFF8FAFC);
}
