import 'package:material_ui/material_ui.dart';

/// Central palette for the ERP application.
abstract final class AppColors {
  // Brand
  static const primary = Color(0xFF245B82);
  static const primaryDark = Color(0xFF173E5B);
  static const primaryLight = Color(0xFFE8F1F7);

  // Neutrals
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF161B22);
  static const pageBackground = Color(0xFFF5F7FA);
  static const surface = Color(0xFFFFFFFF);
  static const border = Color(0xFFE2E7ED);
  static const textPrimary = Color(0xFF202833);
  static const textSecondary = Color(0xFF687586);
  static const disabled = Color(0xFFADB7C2);

  // Semantic states
  static const success = Color(0xFF238653);
  static const successLight = Color(0xFFE8F5ED);
  static const warning = Color(0xFFD99A22);
  static const warningLight = Color(0xFFFFF5DF);
  static const error = Color(0xFFC83D3D);
  static const errorLight = Color(0xFFFCEBEC);
  static const info = Color(0xFF2878B8);
  static const infoLight = Color(0xFFEAF3FB);

  // Sidebar
  static const sidebarBackground = Color(0xFF173E5B);
  static const sidebarForeground = Color(0xFFEAF1F6);
  static const sidebarSelected = Color(0xFF245B82);
  static const sidebarSelectedIndicator = Color(0xFF70B7E2);
}
