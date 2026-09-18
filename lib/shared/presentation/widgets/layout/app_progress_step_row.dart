import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/icon_tone.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/content/app_product_icon.dart';
import 'package:flutter/material.dart';

class AppProgressStepRow extends StatelessWidget {
  const AppProgressStepRow({
    required this.icon,
    required this.when,
    required this.what,
    this.tone = IconTone.muted,
    this.isCurrent = false,
    super.key,
  });

  final IconData icon;
  final String when;
  final String what;
  final IconTone tone;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color muted = theme.colorScheme.onSurfaceVariant;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppDimens.space12,
      children: <Widget>[
        AppProductIcon(icon, tone: tone),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(when, style: theme.textTheme.bodyMedium?.copyWith(color: muted)),
              Text(
                what,
                style: isCurrent
                    ? theme.textTheme.titleMedium
                    : theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurface),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
