import 'package:material_ui/material_ui.dart';

import 'app_colors.dart';

/// Shared typography scale. Prefer Theme.of(context).textTheme in widgets.
abstract final class AppTextStyles {
  // Uses Flutter's default Roboto font stack; no extra package is required.
  static const fontFamily = 'Roboto';

  static const display = TextStyle(
    fontFamily: fontFamily, fontSize: 32, height: 1.2,
    fontWeight: FontWeight.w700, color: AppColors.textPrimary,
  );
  static const headline1 = TextStyle(
    fontFamily: fontFamily, fontSize: 28, height: 1.25,
    fontWeight: FontWeight.w700, color: AppColors.textPrimary,
  );
  static const headline2 = TextStyle(
    fontFamily: fontFamily, fontSize: 24, height: 1.3,
    fontWeight: FontWeight.w700, color: AppColors.textPrimary,
  );
  static const headline3 = TextStyle(
    fontFamily: fontFamily, fontSize: 20, height: 1.35,
    fontWeight: FontWeight.w600, color: AppColors.textPrimary,
  );
  static const title = TextStyle(
    fontFamily: fontFamily, fontSize: 16, height: 1.4,
    fontWeight: FontWeight.w600, color: AppColors.textPrimary,
  );
  static const body = TextStyle(
    fontFamily: fontFamily, fontSize: 14, height: 1.5,
    fontWeight: FontWeight.w400, color: AppColors.textPrimary,
  );
  static const bodySmall = TextStyle(
    fontFamily: fontFamily, fontSize: 12, height: 1.45,
    fontWeight: FontWeight.w400, color: AppColors.textSecondary,
  );
  static const label = TextStyle(
    fontFamily: fontFamily, fontSize: 13, height: 1.3,
    fontWeight: FontWeight.w500, color: AppColors.textSecondary,
  );
  static const button = TextStyle(
    fontFamily: fontFamily, fontSize: 14, height: 1.2,
    fontWeight: FontWeight.w600,
  );
  static const tableHeader = TextStyle(
    fontFamily: fontFamily, fontSize: 12, height: 1.3,
    fontWeight: FontWeight.w600, color: AppColors.textSecondary,
  );
  static const metricValue = TextStyle(
    fontFamily: fontFamily, fontSize: 26, height: 1.2,
    fontWeight: FontWeight.w700, color: AppColors.textPrimary,
  );

  static TextTheme get textTheme => const TextTheme(
    displayLarge: display,
    headlineLarge: headline1,
    headlineMedium: headline2,
    headlineSmall: headline3,
    titleLarge: title,
    bodyLarge: body,
    bodyMedium: body,
    bodySmall: bodySmall,
    labelLarge: button,
    labelMedium: label,
    labelSmall: tableHeader,
  );
}
