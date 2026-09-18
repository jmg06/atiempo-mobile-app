import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:flutter/material.dart';

class AppOrDivider extends StatelessWidget {
  const AppOrDivider({this.label = 'o', super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Widget rule = Expanded(child: Container(height: 1, color: theme.colorScheme.outlineVariant));

    return Row(
      spacing: AppDimens.space12,
      children: <Widget>[
        rule,
        Text(label, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        rule,
      ],
    );
  }
}
