import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/actions/app_primary_button.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/actions/app_secondary_button.dart';
import 'package:flutter/material.dart';

class AppActionPair extends StatelessWidget {
  const AppActionPair({
    this.confirmLabel,
    this.onConfirm,
    this.isConfirmWorking = false,
    this.delegateLabel,
    this.onDelegate,
    super.key,
  });

  final String? confirmLabel;
  final VoidCallback? onConfirm;
  final bool isConfirmWorking;
  final String? delegateLabel;
  final VoidCallback? onDelegate;

  @override
  Widget build(BuildContext context) {
    final List<Widget> actions = <Widget>[
      if (confirmLabel != null)
        AppPrimaryButton(label: confirmLabel!, onPressed: onConfirm, isWorking: isConfirmWorking),
      if (delegateLabel != null) AppSecondaryButton(label: delegateLabel!, onPressed: onDelegate),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      spacing: AppDimens.space12,
      children: actions,
    );
  }
}
