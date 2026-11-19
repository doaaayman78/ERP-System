import 'package:material_ui/material_ui.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

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
    Color? sidebarBackground, Color? sidebarForeground, Color? sidebarSelected,
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
      cardTheme: CardThemeData(
        color: AppColors.white,
        elevation: 0,
        margin: EdgeInsets.zero,
        surfaceTintColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
      dividerTheme: const DividerThemeData(color: AppColors.border, thickness: 1),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        hintStyle: AppTextStyles.bodySmall,
        labelStyle: AppTextStyles.label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          minimumSize: const Size(0, 40),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          textStyle: AppTextStyles.button,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size(0, 40),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          textStyle: AppTextStyles.button,
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
