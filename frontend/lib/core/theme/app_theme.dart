import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

/// Semantic colors beyond the standard Material ColorScheme.
@immutable
class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  const AppSemanticColors({
    required this.success,
    required this.successContainer,
    required this.warning,
    required this.warningContainer,
    required this.info,
    required this.infoContainer,
    required this.sidebarBackground,
    required this.sidebarForeground,
    required this.sidebarSelected,
  });

  final Color success, successContainer, warning, warningContainer;
  final Color info, infoContainer;
  final Color sidebarBackground, sidebarForeground, sidebarSelected;

  @override
  AppSemanticColors copyWith({
    Color? success, Color? successContainer, Color? warning,
    Color? warningContainer, Color? info, Color? infoContainer,
    Color? sidebarBackground, Color? sidebarForeground,
    Color? sidebarSelected,
  }) => AppSemanticColors(
    success: success ?? this.success,
    successContainer: successContainer ?? this.successContainer,
    warning: warning ?? this.warning,
    warningContainer: warningContainer ?? this.warningContainer,
    info: info ?? this.info,
    infoContainer: infoContainer ?? this.infoContainer,
    sidebarBackground: sidebarBackground ?? this.sidebarBackground,
    sidebarForeground: sidebarForeground ?? this.sidebarForeground,
    sidebarSelected: sidebarSelected ?? this.sidebarSelected,
  );

  @override
  AppSemanticColors lerp(covariant AppSemanticColors? other, double t) {
    if (other == null) return this;
    return AppSemanticColors(
      success: Color.lerp(success, other.success, t)!,
      successContainer: Color.lerp(successContainer, other.successContainer, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      warningContainer: Color.lerp(warningContainer, other.warningContainer, t)!,
      info: Color.lerp(info, other.info, t)!,
      infoContainer: Color.lerp(infoContainer, other.infoContainer, t)!,
      sidebarBackground: Color.lerp(sidebarBackground, other.sidebarBackground, t)!,
      sidebarForeground: Color.lerp(sidebarForeground, other.sidebarForeground, t)!,
      sidebarSelected: Color.lerp(sidebarSelected, other.sidebarSelected, t)!,
    );
  }
}

abstract final class AppTheme {
  static const semanticColors = AppSemanticColors(
    success: AppColors.success,
    successContainer: AppColors.successLight,
    warning: AppColors.warning,
    warningContainer: AppColors.warningLight,
    info: AppColors.info,
    infoContainer: AppColors.infoLight,
    sidebarBackground: AppColors.sidebarBackground,
    sidebarForeground: AppColors.sidebarForeground,
    sidebarSelected: AppColors.sidebarSelected,
  );

  static ThemeData get light {
    const scheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary, onPrimary: AppColors.white,
      secondary: AppColors.info, onSecondary: AppColors.white,
      error: AppColors.error, onError: AppColors.white,
      surface: AppColors.surface, onSurface: AppColors.textPrimary,
      outline: AppColors.border, outlineVariant: AppColors.border,
      shadow: AppColors.black, scrim: AppColors.black,
      inverseSurface: AppColors.black, onInverseSurface: AppColors.white,
      inversePrimary: AppColors.primaryLight, surfaceTint: AppColors.primary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.pageBackground,
      fontFamily: AppTextStyles.fontFamily,
      textTheme: AppTextStyles.textTheme,
      extensions: const <ThemeExtension<dynamic>>[semanticColors],
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: false,
        surfaceTintColor: AppColors.white,
        titleTextStyle: AppTextStyles.title,
      ),
      cardTheme: CardThemeData(
        color: AppColors.white,
        elevation: 0,
        margin: EdgeInsets.zero,
        surfaceTintColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
      dividerTheme: const DividerThemeData(color: AppColors.border, thickness: 1),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        hintStyle: AppTextStyles.bodySmall,
        labelStyle: AppTextStyles.label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          disabledBackgroundColor: AppColors.disabled,
          disabledForegroundColor: AppColors.white,
          minimumSize: Size(0, 44.h),
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
          textStyle: AppTextStyles.button,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: Size(0, 44.h),
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
          textStyle: AppTextStyles.button,
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: AppTextStyles.button,
        ),
      ),
      dataTableTheme: DataTableThemeData(
        headingTextStyle: AppTextStyles.tableHeader,
        dataTextStyle: AppTextStyles.body,
        dividerThickness: 1,
        horizontalMargin: 16.w,
        columnSpacing: 24.w,
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: AppColors.sidebarBackground,
        selectedIconTheme: const IconThemeData(color: AppColors.white),
        unselectedIconTheme: const IconThemeData(color: AppColors.sidebarForeground),
        selectedLabelTextStyle: TextStyle(
          fontSize: 14.sp,
          color: AppColors.white, fontWeight: FontWeight.w600,
        ),
        unselectedLabelTextStyle: TextStyle(
          fontSize: 14.sp,
          color: AppColors.sidebarForeground,
        ),
      ),
    );
  }

  /// Starter dark theme. Validate all screens and chart colors before enabling.
  static ThemeData get dark {
    const darkSurface = Color(0xFF1D2731);
    const darkText = Color(0xFFE9EEF3);
    const outline = Color(0xFF465461);
    const scheme = ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF79B5D9), onPrimary: Color(0xFF102B3D),
      secondary: Color(0xFF82BCE4), onSecondary: Color(0xFF102B3D),
      error: Color(0xFFFF8585), onError: Color(0xFF3A1010),
      surface: darkSurface, onSurface: darkText,
      outline: outline, outlineVariant: Color(0xFF384652),
      shadow: AppColors.black, scrim: AppColors.black,
      inverseSurface: darkText, onInverseSurface: darkSurface,
      inversePrimary: AppColors.primary, surfaceTint: Color(0xFF79B5D9),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: const Color(0xFF141C24),
      fontFamily: AppTextStyles.fontFamily,
      textTheme: AppTextStyles.textTheme.apply(
        bodyColor: darkText, displayColor: darkText,
      ),
      extensions: const <ThemeExtension<dynamic>>[semanticColors],
      dividerTheme: const DividerThemeData(color: Color(0xFF384652)),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkSurface,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Color(0xFF79B5D9), width: 1.5),
        ),
      ),
    );
  }
}
