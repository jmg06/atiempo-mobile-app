import 'package:flutter/material.dart';

class AppSectionLabel extends StatelessWidget {
  const AppSectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Text(text, style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant));
  }
}
