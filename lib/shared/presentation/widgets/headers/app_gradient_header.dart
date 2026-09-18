import 'package:atiempo_mobile_app/config/theme/app_colors.dart';
import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/headers/app_day_progress_bar.dart';
import 'package:flutter/material.dart';

class AppGradientHeader extends StatelessWidget {
  const AppGradientHeader({required this.title, required this.subtitle, required this.progress, super.key});

  final String title;
  final String subtitle;

  /// Between 0 and 1.
  final double progress;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color onBrand = theme.colorScheme.onPrimary;

    return DecoratedBox(
      decoration: BoxDecoration(gradient: context.appColors.brandGradient),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.space16, vertical: AppDimens.space20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: <Widget>[
            Text(title, style: theme.textTheme.headlineLarge?.copyWith(color: onBrand)),
            Text(subtitle, style: theme.textTheme.bodyLarge?.copyWith(color: onBrand)),
            AppDayProgressBar(progress: progress),
          ],
        ),
      ),
    );
  }
}
