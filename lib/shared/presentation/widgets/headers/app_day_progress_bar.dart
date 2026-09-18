import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:flutter/material.dart';

class AppDayProgressBar extends StatelessWidget {
  const AppDayProgressBar({required this.progress, this.trackColor, this.color, super.key});

  /// Between 0 and 1.
  final double progress;
  final Color? trackColor;
  final Color? color;

  static const double _thickness = 8;

  /// Holds the edge between met and unmet at the 3:1 the WCAG asks of an informative graphic,
  /// measured against the lightest end of the gradient underneath.
  static const double _trackOpacity = 0.16;

  @override
  Widget build(BuildContext context) {
    final Color fill = color ?? Theme.of(context).colorScheme.onPrimary;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimens.cornerFull),
      child: SizedBox(
        height: _thickness,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            ColoredBox(color: trackColor ?? fill.withValues(alpha: _trackOpacity)),
            FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress.clamp(0, 1),
              child: ColoredBox(color: fill),
            ),
          ],
        ),
      ),
    );
  }
}
