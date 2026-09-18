import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/inputs/app_radio.dart';
import 'package:flutter/material.dart';

class AppPersonOptionRow<T> extends StatelessWidget {
  const AppPersonOptionRow({
    required this.value,
    required this.name,
    required this.role,
    this.isEnabled = true,
    super.key,
  });

  final T value;
  final String name;
  final String role;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.space4, vertical: AppDimens.space12),
          child: Row(
            spacing: AppDimens.space16,
            children: <Widget>[
              AppRadio<T>(value: value, isEnabled: isEnabled),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 2,
                  children: <Widget>[
                    Text(name, style: theme.textTheme.bodyLarge),
                    Text(role, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(height: 1, thickness: 1, color: theme.colorScheme.outlineVariant),
      ],
    );
  }
}
