import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:atiempo_mobile_app/shared/presentation/icons/app_icons.dart';
import 'package:flutter/material.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({required this.label, required this.onPressed, this.isWorking = false, super.key});

  final String label;
  final VoidCallback? onPressed;
  final bool isWorking;

  @override
  Widget build(BuildContext context) {
    final Widget text = Text(label);

    return SizedBox(
      width: double.infinity,
      child: isWorking
          ? FilledButton.icon(
              onPressed: null,
              icon: const Icon(AppIcons.pending, size: AppDimens.iconSize),
              label: text,
            )
          : FilledButton(onPressed: onPressed, child: text),
    );
  }
}
