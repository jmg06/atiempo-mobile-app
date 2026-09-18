import 'package:atiempo_mobile_app/config/theme/app_button_styles.dart';
import 'package:atiempo_mobile_app/config/theme/app_colors.dart';
import 'package:atiempo_mobile_app/config/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// Material 3 theme of the app, light mode only.
class AppTheme {
  ThemeData getTheme() {
    const ColorScheme colors = appColorScheme;

    return ThemeData(
      colorScheme: colors,
      fontFamily: AppTypography.fontFamily,
      textTheme: AppTypography.textTheme,
      scaffoldBackgroundColor: colors.surface,
      iconTheme: IconThemeData(color: colors.onSurface, size: 24),
      dividerTheme: DividerThemeData(color: colors.outlineVariant, thickness: 1, space: 1),
      extensions: const [AppColors.light],
      filledButtonTheme: FilledButtonThemeData(
        style: AppButtonStyles.medium(colors: colors, background: colors.primary, foreground: colors.onPrimary),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: AppButtonStyles.medium(
          colors: colors,
          foreground: colors.onSurfaceVariant,
          side: BorderSide(color: colors.outlineVariant),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: AppButtonStyles.medium(colors: colors, foreground: colors.primary),
      ),
      inputDecorationTheme: _inputDecorationTheme(colors),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: BorderSide(color: colors.outlineVariant),
        labelStyle: AppTypography.labelLarge.copyWith(color: colors.onSurfaceVariant),
        // The chip adds its 1 px border to this padding.
        // Status pills also need `VisualDensity(vertical: -1)` to stay 32 high.
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
        labelPadding: const EdgeInsets.symmetric(horizontal: 8),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colors.surfaceContainerHigh,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        titleTextStyle: AppTypography.headlineSmall.copyWith(color: colors.onSurface),
        contentTextStyle: AppTypography.bodyMedium.copyWith(color: colors.onSurfaceVariant),
        // Content padding is not themeable: dialogs pass a bottom of 20.
        actionsPadding: const EdgeInsets.fromLTRB(8, 0, 24, 20),
        barrierColor: colors.scrim.withValues(alpha: 0.32),
      ),
      cardTheme: CardThemeData(
        color: colors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: colors.outlineVariant),
        ),
      ),
    );
  }

  InputDecorationThemeData _inputDecorationTheme(ColorScheme colors) {
    OutlineInputBorder border(Color color, double width) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: color, width: width),
    );

    Color stateColor(Set<WidgetState> states, {required Color idle}) {
      if (states.contains(WidgetState.disabled)) {
        return colors.onSurface.withValues(alpha: 0.38);
      }
      if (states.contains(WidgetState.error)) {
        return colors.error;
      }
      if (states.contains(WidgetState.focused)) {
        return colors.primary;
      }
      return idle;
    }

    // Flutter scales the floating label to 0.75, so this lands on Body Small.
    const double floatingLabelScale = 0.75;
    final TextStyle floatingLabel = AppTypography.bodySmall.copyWith(
      fontSize: AppTypography.bodySmall.fontSize! / floatingLabelScale,
    );

    return InputDecorationThemeData(
      // Flutter adds the 4 px border gap on each side, for 16 in total.
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      border: border(colors.outline, 1),
      enabledBorder: border(colors.outline, 1),
      focusedBorder: border(colors.primary, 3),
      errorBorder: border(colors.error, 3),
      focusedErrorBorder: border(colors.error, 3),
      disabledBorder: border(colors.onSurface.withValues(alpha: 0.10), 1),
      labelStyle: WidgetStateTextStyle.resolveWith(
        (states) => AppTypography.bodyLarge.copyWith(color: stateColor(states, idle: colors.onSurfaceVariant)),
      ),
      floatingLabelStyle: WidgetStateTextStyle.resolveWith(
        (states) => floatingLabel.copyWith(color: stateColor(states, idle: colors.onSurfaceVariant)),
      ),
      hintStyle: AppTypography.bodyLarge.copyWith(color: colors.onSurfaceVariant),
      helperStyle: WidgetStateTextStyle.resolveWith(
        (states) => AppTypography.bodySmall.copyWith(
          color: states.contains(WidgetState.disabled)
              ? colors.onSurface.withValues(alpha: 0.38)
              : colors.onSurfaceVariant,
        ),
      ),
      errorStyle: AppTypography.bodySmall.copyWith(color: colors.error),
      suffixIconColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return colors.onSurface.withValues(alpha: 0.38);
        }
        return states.contains(WidgetState.error) ? colors.error : colors.onSurfaceVariant;
      }),
    );
  }
}
