import 'package:atiempo_mobile_app/config/theme/app_colors.dart';
import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/status_pill_kind.dart';
import 'package:flutter/material.dart';

class AppStatusPill extends StatelessWidget {
  const AppStatusPill({required this.kind, required this.label, super.key});

  final StatusPillKind kind;
  final String label;

  static const double _height = 32;
  static const double _horizontalPadding = 14;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final (Color container, Color onContainer) = _colors(context);

    return Container(
      height: _height,
      padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
      decoration: BoxDecoration(
        color: container,
        borderRadius: BorderRadius.circular(AppDimens.cornerSmall),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      // Without the width factor the centring alone stretches the pill to every pixel its
      // parent allows.
      child: Center(
        widthFactor: 1,
        child: Text(label, style: theme.textTheme.labelLarge?.copyWith(color: onContainer)),
      ),
    );
  }

  (Color, Color) _colors(BuildContext context) {
    final AppColors colors = context.appColors;
    return switch (kind) {
      StatusPillKind.done => (colors.stateDone, colors.onStateDone),
      StatusPillKind.pending => (colors.statePendingContainer, colors.onStatePendingContainer),
      StatusPillKind.scheduled => (colors.stateScheduledContainer, colors.onStateScheduledContainer),
      StatusPillKind.delegated => (colors.stateDelegatedContainer, colors.onStateDelegatedContainer),
      StatusPillKind.skipped => (colors.stateMissed, colors.onStateMissed),
      StatusPillKind.notAccepted => (colors.statePendingContainer, colors.onStatePendingContainer),
    };
  }
}
