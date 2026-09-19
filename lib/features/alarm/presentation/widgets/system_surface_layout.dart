import 'dart:math' as math;

import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/chrome/app_system_backdrop.dart';
import 'package:flutter/material.dart';

class SystemSurfaceLayout extends StatelessWidget {
  const SystemSurfaceLayout({required this.time, required this.children, this.bottomGap, super.key});

  final String time;
  final List<Widget> children;

  /// Distance from the bottom edge of the phone. Without it, the group hangs from [_topOffset].
  final double? bottomGap;

  static const String _date = 'martes 12 de agosto';
  static const double _topOffset = 248;

  @override
  Widget build(BuildContext context) {
    final double bottomInset = MediaQuery.paddingOf(context).bottom;
    final Widget group = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      spacing: AppDimens.space12,
      children: children,
    );

    return Scaffold(
      body: AppSystemBackdrop(
        time: time,
        date: _date,
        child: bottomGap == null
            ? SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppDimens.mobileMargin,
                  _topOffset,
                  AppDimens.mobileMargin,
                  AppDimens.space16,
                ),
                child: group,
              )
            : Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    AppDimens.mobileMargin,
                    0,
                    AppDimens.mobileMargin,
                    math.max(0, bottomGap! - bottomInset),
                  ),
                  child: group,
                ),
              ),
      ),
    );
  }
}
