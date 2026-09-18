import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/medication_form.dart';
import 'package:atiempo_mobile_app/shared/presentation/icons/app_icons.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/content/app_product_icon.dart';
import 'package:flutter/material.dart';

class AppMedicationRow extends StatelessWidget {
  const AppMedicationRow({required this.name, required this.amount, required this.form, super.key});

  final String name;
  final String amount;
  final MedicationForm form;

  static const double _markSize = 44;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
      spacing: AppDimens.space12,
      children: <Widget>[
        Container(
          width: _markSize,
          height: _markSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(AppDimens.cornerMedium),
          ),
          child: AppProductIcon(form == MedicationForm.solid ? AppIcons.medication : AppIcons.medicationLiquid),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 2,
            children: <Widget>[
              Text(name, style: theme.textTheme.titleMedium),
              Text(amount, style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            ],
          ),
        ),
      ],
    );
  }
}
