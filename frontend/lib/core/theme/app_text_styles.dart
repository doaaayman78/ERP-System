import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';
import 'app_colors.dart';

/// Shared typography scale. Prefer Theme.of(context).textTheme in widgets.
///
/// All font sizes are scaled via flutter_screenutil (.sp) so they respond
/// to the design-reference dimensions configured in ScreenUtil.init().
abstract final class AppTextStyles {
  // Uses Flutter's default Roboto font stack; no extra package is required.
  static const fontFamily = 'Roboto';

  static TextStyle get display => TextStyle(
    fontFamily: fontFamily, fontSize: 32.sp, height: 1.2,
    fontWeight: FontWeight.w700, color: AppColors.textPrimary,
  );
  static TextStyle get headline1 => TextStyle(
    fontFamily: fontFamily, fontSize: 28.sp, height: 1.25,
    fontWeight: FontWeight.w700, color: AppColors.textPrimary,
  );
  static TextStyle get headline2 => TextStyle(
    fontFamily: fontFamily, fontSize: 24.sp, height: 1.3,
    fontWeight: FontWeight.w700, color: AppColors.textPrimary,
  );
  static TextStyle get headline3 => TextStyle(
    fontFamily: fontFamily, fontSize: 20.sp, height: 1.35,
    fontWeight: FontWeight.w600, color: AppColors.textPrimary,
  );
  static TextStyle get title => TextStyle(
    fontFamily: fontFamily, fontSize: 16.sp, height: 1.4,
    fontWeight: FontWeight.w600, color: AppColors.textPrimary,
  );
  static TextStyle get body => TextStyle(
    fontFamily: fontFamily, fontSize: 14.sp, height: 1.5,
    fontWeight: FontWeight.w400, color: AppColors.textPrimary,
  );
  static TextStyle get bodySmall => TextStyle(
    fontFamily: fontFamily, fontSize: 12.sp, height: 1.45,
    fontWeight: FontWeight.w400, color: AppColors.textSecondary,
  );
  static TextStyle get label => TextStyle(
    fontFamily: fontFamily, fontSize: 13.sp, height: 1.3,
    fontWeight: FontWeight.w500, color: AppColors.textSecondary,
  );
  static TextStyle get button => TextStyle(
    fontFamily: fontFamily, fontSize: 14.sp, height: 1.2,
    fontWeight: FontWeight.w600,
  );
  static TextStyle get tableHeader => TextStyle(
    fontFamily: fontFamily, fontSize: 12.sp, height: 1.3,
    fontWeight: FontWeight.w600, color: AppColors.textSecondary,
  );
  static TextStyle get metricValue => TextStyle(
    fontFamily: fontFamily, fontSize: 26.sp, height: 1.2,
    fontWeight: FontWeight.w700, color: AppColors.textPrimary,
  );

  static TextTheme get textTheme => TextTheme(
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
