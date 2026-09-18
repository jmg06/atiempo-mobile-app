import 'package:atiempo_mobile_app/config/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// Button styles shared by the button themes, plus the variants a global theme cannot express.
abstract final class AppButtonStyles {
  static const WidgetStateProperty<OutlinedBorder> shape = WidgetStatePropertyAll<OutlinedBorder>(StadiumBorder());

  /// State layer tinted with the label color.
  static WidgetStateProperty<Color?> overlay(Color color) => WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.pressed)) {
      return color.withValues(alpha: 0.08);
    }
    if (states.contains(WidgetState.focused)) {
      return color.withValues(alpha: 0.10);
    }
    if (states.contains(WidgetState.hovered)) {
      return color.withValues(alpha: 0.08);
    }
    return null;
  });

  /// Container color, with the shared disabled container.
  static WidgetStateProperty<Color?> container(ColorScheme colors, Color? enabled) => WidgetStateProperty.resolveWith(
    (states) => states.contains(WidgetState.disabled) ? colors.onSurface.withValues(alpha: 0.10) : enabled,
  );

  /// Label and icon color, with the shared disabled label.
  static WidgetStateProperty<Color?> content(ColorScheme colors, Color enabled) => WidgetStateProperty.resolveWith(
    (states) => states.contains(WidgetState.disabled) ? colors.onSurface.withValues(alpha: 0.38) : enabled,
  );

  /// Medium size, used by the global button themes.
  static ButtonStyle medium({
    required ColorScheme colors,
    required Color foreground,
    Color? background,
    BorderSide? side,
  }) {
    return ButtonStyle(
      minimumSize: const WidgetStatePropertyAll(Size(64, 56)),
      padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 24, vertical: 16)),
      textStyle: const WidgetStatePropertyAll(AppTypography.titleMedium),
      iconSize: const WidgetStatePropertyAll(24),
      shape: shape,
      side: side == null ? null : WidgetStatePropertyAll(side),
      backgroundColor: container(colors, background),
      foregroundColor: content(colors, foreground),
      iconColor: content(colors, foreground),
      overlayColor: overlay(foreground),
      elevation: const WidgetStatePropertyAll(0),
    );
  }

  /// Small size, for dialog actions and header controls. Colors come from the button theme.
  static const ButtonStyle small = ButtonStyle(
    minimumSize: WidgetStatePropertyAll(Size(48, 40)),
    padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16, vertical: 10)),
    textStyle: WidgetStatePropertyAll(AppTypography.labelLarge),
    iconSize: WidgetStatePropertyAll(20),
  );
}
