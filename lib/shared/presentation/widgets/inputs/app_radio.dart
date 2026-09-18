import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:flutter/material.dart';

class AppRadio<T> extends StatelessWidget {
  const AppRadio({required this.value, this.isEnabled = true, super.key});

  final T value;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: AppDimens.minTouchTarget,
      child: Radio<T>(value: value, enabled: isEnabled),
    );
  }
}
