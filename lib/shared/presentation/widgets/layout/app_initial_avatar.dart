import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:flutter/material.dart';

class AppInitialAvatar extends StatelessWidget {
  const AppInitialAvatar(this.initial, {this.size = AppDimens.space48, super.key});

  final String initial;
  final double size;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: theme.colorScheme.primaryContainer, shape: BoxShape.circle),
      child: Text(initial, style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onPrimaryContainer)),
    );
  }
}
