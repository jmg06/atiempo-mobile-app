import 'package:atiempo_mobile_app/config/theme/app_colors.dart';
import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/icon_tone.dart';
import 'package:flutter/material.dart';

class AppProductIcon extends StatelessWidget {
  const AppProductIcon(this.icon, {this.tone = IconTone.ink, this.size = AppDimens.iconSize, this.color, super.key});

  final IconData icon;
  final IconTone tone;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: size, color: _color(context));
  }

  Color _color(BuildContext context) {
    if (color != null) {
      return color!;
    }

    final ColorScheme colors = Theme.of(context).colorScheme;
    return switch (tone) {
      IconTone.ink => colors.onSurface,
      IconTone.muted => colors.onSurfaceVariant,
      IconTone.done => context.appColors.stateDone,
      IconTone.attention => context.appColors.statePending,
      IconTone.delegated => context.appColors.stateDelegated,
      IconTone.onBrand => colors.onPrimary,
    };
  }
}
