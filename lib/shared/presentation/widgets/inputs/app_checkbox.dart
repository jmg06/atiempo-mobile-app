import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:flutter/material.dart';

class AppCheckbox extends StatelessWidget {
  const AppCheckbox({required this.value, required this.onChanged, this.label, this.isEnabled = true, super.key});

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final Widget box = SizedBox.square(
      dimension: AppDimens.minTouchTarget,
      child: Checkbox(
        value: value,
        onChanged: isEnabled && onChanged != null ? (bool? next) => onChanged!(next ?? false) : null,
      ),
    );

    if (label == null) {
      return box;
    }

    return InkWell(
      onTap: isEnabled && onChanged != null ? () => onChanged!(!value) : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppDimens.space8,
        children: <Widget>[
          box,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppDimens.space12),
              child: Text(label!, style: Theme.of(context).textTheme.bodyLarge),
            ),
          ),
        ],
      ),
    );
  }
}
