import 'package:atiempo_mobile_app/config/theme/app_button_styles.dart';
import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:flutter/material.dart';

class AppScreenHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppScreenHeader({this.onBack, super.key});

  final VoidCallback? onBack;

  static const String _backLabel = 'VOLVER';
  static const double _barHeight = 64;
  static const double _dividerHeight = 1;

  @override
  Size get preferredSize => const Size.fromHeight(_barHeight + _dividerHeight);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ColoredBox(
      color: theme.colorScheme.surface,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: _barHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.space8),
              child: Row(
                children: <Widget>[
                  TextButton(style: AppButtonStyles.small, onPressed: onBack, child: const Text(_backLabel)),
                ],
              ),
            ),
          ),
          Divider(height: _dividerHeight, thickness: _dividerHeight, color: theme.colorScheme.outlineVariant),
        ],
      ),
    );
  }
}
