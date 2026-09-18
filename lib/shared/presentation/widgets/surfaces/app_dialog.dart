import 'package:atiempo_mobile_app/config/theme/app_button_styles.dart';
import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.onConfirm,
    this.dismissLabel,
    this.onDismiss,
    super.key,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final VoidCallback? onConfirm;
  final String? dismissLabel;
  final VoidCallback? onDismiss;

  static const double _width = 312;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SizedBox(width: _width, child: Text(message)),
      titlePadding: const EdgeInsets.fromLTRB(AppDimens.space24, AppDimens.space24, AppDimens.space24, 0),
      contentPadding: const EdgeInsets.fromLTRB(AppDimens.space24, AppDimens.space16, AppDimens.space24, 0),
      actions: <Widget>[
        if (dismissLabel != null)
          TextButton(style: AppButtonStyles.small, onPressed: onDismiss, child: Text(dismissLabel!)),
        TextButton(style: AppButtonStyles.small, onPressed: onConfirm, child: Text(confirmLabel)),
      ],
    );
  }
}
