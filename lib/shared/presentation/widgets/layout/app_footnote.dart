import 'package:flutter/material.dart';

class AppFootnote extends StatelessWidget {
  const AppFootnote(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Text(text, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant));
  }
}
