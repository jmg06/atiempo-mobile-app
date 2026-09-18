import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/icon_tone.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/content/app_product_icon.dart';
import 'package:flutter/material.dart';

class AppSystemNotice extends StatelessWidget {
  const AppSystemNotice({
    required this.icon,
    required this.title,
    required this.body,
    this.iconTone = IconTone.ink,
    this.timestamp = 'ahora',
    this.actions,
    super.key,
  });

  final IconData icon;
  final IconTone iconTone;
  final String title;
  final String body;
  final String timestamp;
  final Widget? actions;

  static const String _source = 'a tiempo';

  /// Material elevation level 3.
  static const List<BoxShadow> _elevation = <BoxShadow>[
    BoxShadow(color: Color(0x26161D1B), offset: Offset(0, 1), blurRadius: 3),
    BoxShadow(color: Color(0x4D161D1B), offset: Offset(0, 4), blurRadius: 8, spreadRadius: 3),
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle? micro = theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant);

    return Container(
      padding: const EdgeInsets.all(AppDimens.space16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppDimens.cornerLarge),
        boxShadow: _elevation,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: AppDimens.space8,
        children: <Widget>[
          Row(
            spacing: AppDimens.space8,
            children: <Widget>[
              AppProductIcon(icon, tone: iconTone, size: AppDimens.iconSizeSmall),
              Expanded(child: Text(_source, style: micro)),
              Text(timestamp, style: micro),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: Text(title, style: theme.textTheme.titleMedium),
          ),
          SizedBox(
            width: double.infinity,
            child: Text(body, style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          ),
          if (actions != null)
            Padding(
              padding: const EdgeInsets.only(top: AppDimens.space4),
              child: actions,
            ),
        ],
      ),
    );
  }
}
