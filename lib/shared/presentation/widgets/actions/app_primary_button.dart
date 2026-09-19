import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:flutter/material.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({required this.label, required this.onPressed, this.isWorking = false, super.key});

  final String label;
  final VoidCallback? onPressed;
  final bool isWorking;

  static const String _workingLabel = 'UN MOMENTO';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: isWorking
          ? FilledButton.icon(onPressed: null, icon: const _Spinner(), label: const Text(_workingLabel))
          : FilledButton(onPressed: onPressed, child: Text(label)),
    );
  }
}

class _Spinner extends StatelessWidget {
  const _Spinner();

  static const double _inset = 2;
  static const double _stroke = 3;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: AppDimens.iconSize,
      child: Padding(
        padding: const EdgeInsets.all(_inset),
        child: CircularProgressIndicator(
          strokeWidth: _stroke,
          strokeCap: StrokeCap.round,
          color: IconTheme.of(context).color,
        ),
      ),
    );
  }
}
