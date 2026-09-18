import 'dart:math' as math;

import 'package:atiempo_mobile_app/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

abstract final class AppBrandGradient {
  /// A CSS angle of 0 points up and grows clockwise; a Flutter gradient laid out from
  /// centre-left to centre-right already points at 90.
  static LinearGradient _atAngle(BuildContext context, double cssDegrees) {
    final AppColors colors = context.appColors;

    return LinearGradient(
      colors: <Color>[colors.brandGradientEnd, colors.brandGradientStart],
      stops: const <double>[0.14644, 0.85356],
      transform: GradientRotation((cssDegrees - 90) * math.pi / 180),
    );
  }

  static LinearGradient access(BuildContext context) => _atAngle(context, 160.91151549640017);

  static LinearGradient backdrop(BuildContext context) => _atAngle(context, 114.76234562051556);
}
