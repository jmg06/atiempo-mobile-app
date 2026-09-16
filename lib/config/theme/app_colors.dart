import 'package:flutter/material.dart';

/// Material color roles, light mode.
const ColorScheme appColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF0E5A50),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF8AF5E0),
  onPrimaryContainer: Color(0xFF00201B),
  primaryFixed: Color(0xFF8AF5E0),
  primaryFixedDim: Color(0xFF6DD9C4),
  onPrimaryFixed: Color(0xFF00201B),
  onPrimaryFixedVariant: Color(0xFF005045),
  secondary: Color(0xFF55625D),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFE4EFEC),
  onSecondaryContainer: Color(0xFF2A3230),
  secondaryFixed: Color(0xFFE4EFEC),
  secondaryFixedDim: Color(0xFFBFC9C6),
  onSecondaryFixed: Color(0xFF161D1B),
  onSecondaryFixedVariant: Color(0xFF404946),
  tertiary: Color(0xFF12907E),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFF8EC8BE),
  onTertiaryContainer: Color(0xFF00201B),
  tertiaryFixed: Color(0xFF8EC8BE),
  tertiaryFixedDim: Color(0xFF50BDA9),
  onTertiaryFixed: Color(0xFF00201B),
  onTertiaryFixedVariant: Color(0xFF005045),
  error: Color(0xFFA8480B),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFF7E9DC),
  onErrorContainer: Color(0xFF7A3000),
  surface: Color(0xFFFBFCFB),
  onSurface: Color(0xFF111C19),
  surfaceDim: Color(0xFFDAE5E2),
  surfaceBright: Color(0xFFFFFFFF),
  surfaceContainerLowest: Color(0xFFFFFFFF),
  surfaceContainerLow: Color(0xFFFBFCFB),
  surfaceContainer: Color(0xFFE9EEEC),
  surfaceContainerHigh: Color(0xFFE4EFEC),
  surfaceContainerHighest: Color(0xFFDAE5E2),
  onSurfaceVariant: Color(0xFF55625D),
  outline: Color(0xFF8B9591),
  outlineVariant: Color(0xFFCFD8D4),
  shadow: Color(0xFF161D1B),
  scrim: Color(0xFF161D1B),
  inverseSurface: Color(0xFF2A3230),
  onInverseSurface: Color(0xFFE9F3F0),
  inversePrimary: Color(0xFF6DD9C4),
  surfaceTint: Color(0xFF12907E),
);

/// Brand and dose state colors, which Material does not define.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.brandTeal,
    required this.brandTealDark,
    required this.brandTealLight,
    required this.brandGradientStart,
    required this.brandGradientEnd,
    required this.stateDone,
    required this.onStateDone,
    required this.stateDoneContainer,
    required this.onStateDoneContainer,
    required this.statePending,
    required this.statePendingContainer,
    required this.onStatePendingContainer,
    required this.stateMissed,
    required this.onStateMissed,
    required this.stateScheduled,
    required this.stateScheduledContainer,
    required this.onStateScheduledContainer,
    required this.stateDelegated,
    required this.stateDelegatedContainer,
    required this.onStateDelegatedContainer,
    required this.stateRinging,
    required this.stateRingingContainer,
    required this.stateWorking,
  });

  static const AppColors light = AppColors(
    brandTeal: Color(0xFF12907E),
    brandTealDark: Color(0xFF0E5A50),
    brandTealLight: Color(0xFF8EC8BE),
    brandGradientStart: Color(0xFF12907E),
    brandGradientEnd: Color(0xFF0E5A50),
    stateDone: Color(0xFF0E5A50),
    onStateDone: Color(0xFFFFFFFF),
    stateDoneContainer: Color(0xFF8AF5E0),
    onStateDoneContainer: Color(0xFF00201B),
    statePending: Color(0xFFA8480B),
    statePendingContainer: Color(0xFFF7E9DC),
    onStatePendingContainer: Color(0xFF7A3000),
    stateMissed: Color(0xFFA8480B),
    onStateMissed: Color(0xFFFFFFFF),
    stateScheduled: Color(0xFF55625D),
    stateScheduledContainer: Color(0xFFE4EFEC),
    onStateScheduledContainer: Color(0xFF2A3230),
    stateDelegated: Color(0xFF12907E),
    stateDelegatedContainer: Color(0xFF8EC8BE),
    onStateDelegatedContainer: Color(0xFF00201B),
    stateRinging: Color(0xFFA8480B),
    stateRingingContainer: Color(0xFFF7E9DC),
    stateWorking: Color(0xFF55625D),
  );

  /// Only for large text: white on top reaches 3.95:1.
  final Color brandTeal;
  final Color brandTealDark;
  final Color brandTealLight;
  final Color brandGradientStart;
  final Color brandGradientEnd;

  final Color stateDone;
  final Color onStateDone;
  final Color stateDoneContainer;
  final Color onStateDoneContainer;

  final Color statePending;
  final Color statePendingContainer;
  final Color onStatePendingContainer;

  final Color stateMissed;
  final Color onStateMissed;

  final Color stateScheduled;
  final Color stateScheduledContainer;
  final Color onStateScheduledContainer;

  final Color stateDelegated;
  final Color stateDelegatedContainer;
  final Color onStateDelegatedContainer;

  final Color stateRinging;
  final Color stateRingingContainer;

  final Color stateWorking;

  /// Header gradient, from teal to dark teal.
  LinearGradient get brandGradient => LinearGradient(colors: [brandGradientStart, brandGradientEnd]);

  @override
  AppColors copyWith({
    Color? brandTeal,
    Color? brandTealDark,
    Color? brandTealLight,
    Color? brandGradientStart,
    Color? brandGradientEnd,
    Color? stateDone,
    Color? onStateDone,
    Color? stateDoneContainer,
    Color? onStateDoneContainer,
    Color? statePending,
    Color? statePendingContainer,
    Color? onStatePendingContainer,
    Color? stateMissed,
    Color? onStateMissed,
    Color? stateScheduled,
    Color? stateScheduledContainer,
    Color? onStateScheduledContainer,
    Color? stateDelegated,
    Color? stateDelegatedContainer,
    Color? onStateDelegatedContainer,
    Color? stateRinging,
    Color? stateRingingContainer,
    Color? stateWorking,
  }) {
    return AppColors(
      brandTeal: brandTeal ?? this.brandTeal,
      brandTealDark: brandTealDark ?? this.brandTealDark,
      brandTealLight: brandTealLight ?? this.brandTealLight,
      brandGradientStart: brandGradientStart ?? this.brandGradientStart,
      brandGradientEnd: brandGradientEnd ?? this.brandGradientEnd,
      stateDone: stateDone ?? this.stateDone,
      onStateDone: onStateDone ?? this.onStateDone,
      stateDoneContainer: stateDoneContainer ?? this.stateDoneContainer,
      onStateDoneContainer: onStateDoneContainer ?? this.onStateDoneContainer,
      statePending: statePending ?? this.statePending,
      statePendingContainer: statePendingContainer ?? this.statePendingContainer,
      onStatePendingContainer: onStatePendingContainer ?? this.onStatePendingContainer,
      stateMissed: stateMissed ?? this.stateMissed,
      onStateMissed: onStateMissed ?? this.onStateMissed,
      stateScheduled: stateScheduled ?? this.stateScheduled,
      stateScheduledContainer: stateScheduledContainer ?? this.stateScheduledContainer,
      onStateScheduledContainer: onStateScheduledContainer ?? this.onStateScheduledContainer,
      stateDelegated: stateDelegated ?? this.stateDelegated,
      stateDelegatedContainer: stateDelegatedContainer ?? this.stateDelegatedContainer,
      onStateDelegatedContainer: onStateDelegatedContainer ?? this.onStateDelegatedContainer,
      stateRinging: stateRinging ?? this.stateRinging,
      stateRingingContainer: stateRingingContainer ?? this.stateRingingContainer,
      stateWorking: stateWorking ?? this.stateWorking,
    );
  }

  @override
  AppColors lerp(covariant AppColors? other, double t) {
    if (other == null) {
      return this;
    }

    return AppColors(
      brandTeal: Color.lerp(brandTeal, other.brandTeal, t)!,
      brandTealDark: Color.lerp(brandTealDark, other.brandTealDark, t)!,
      brandTealLight: Color.lerp(brandTealLight, other.brandTealLight, t)!,
      brandGradientStart: Color.lerp(brandGradientStart, other.brandGradientStart, t)!,
      brandGradientEnd: Color.lerp(brandGradientEnd, other.brandGradientEnd, t)!,
      stateDone: Color.lerp(stateDone, other.stateDone, t)!,
      onStateDone: Color.lerp(onStateDone, other.onStateDone, t)!,
      stateDoneContainer: Color.lerp(stateDoneContainer, other.stateDoneContainer, t)!,
      onStateDoneContainer: Color.lerp(onStateDoneContainer, other.onStateDoneContainer, t)!,
      statePending: Color.lerp(statePending, other.statePending, t)!,
      statePendingContainer: Color.lerp(statePendingContainer, other.statePendingContainer, t)!,
      onStatePendingContainer: Color.lerp(onStatePendingContainer, other.onStatePendingContainer, t)!,
      stateMissed: Color.lerp(stateMissed, other.stateMissed, t)!,
      onStateMissed: Color.lerp(onStateMissed, other.onStateMissed, t)!,
      stateScheduled: Color.lerp(stateScheduled, other.stateScheduled, t)!,
      stateScheduledContainer: Color.lerp(stateScheduledContainer, other.stateScheduledContainer, t)!,
      onStateScheduledContainer: Color.lerp(onStateScheduledContainer, other.onStateScheduledContainer, t)!,
      stateDelegated: Color.lerp(stateDelegated, other.stateDelegated, t)!,
      stateDelegatedContainer: Color.lerp(stateDelegatedContainer, other.stateDelegatedContainer, t)!,
      onStateDelegatedContainer: Color.lerp(onStateDelegatedContainer, other.onStateDelegatedContainer, t)!,
      stateRinging: Color.lerp(stateRinging, other.stateRinging, t)!,
      stateRingingContainer: Color.lerp(stateRingingContainer, other.stateRingingContainer, t)!,
      stateWorking: Color.lerp(stateWorking, other.stateWorking, t)!,
    );
  }
}

extension AppColorsContext on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}
