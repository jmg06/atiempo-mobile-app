import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/headers/app_brand_gradient.dart';
import 'package:flutter/material.dart';

class AppAccessHeader extends StatelessWidget {
  const AppAccessHeader({required this.title, this.onBack, super.key});

  final String title;
  final VoidCallback? onBack;

  static const String _brand = 'a tiempo';
  static const String _backLabel = 'VOLVER';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color onBrand = theme.colorScheme.primaryContainer;
    final Widget brand = Text(_brand, style: theme.textTheme.titleMedium?.copyWith(color: onBrand));

    return DecoratedBox(
      decoration: BoxDecoration(gradient: AppBrandGradient.access(context)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppDimens.space16, AppDimens.space16, AppDimens.space16, AppDimens.space24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: AppDimens.space8,
          children: <Widget>[
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: AppDimens.minTouchTarget),
              child: Row(
                mainAxisAlignment: onBack == null ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  if (onBack != null)
                    InkWell(
                      onTap: onBack,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minHeight: AppDimens.minTouchTarget,
                          minWidth: AppDimens.minTouchTarget,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(_backLabel, style: theme.textTheme.labelLarge?.copyWith(color: onBrand)),
                        ),
                      ),
                    ),
                  brand,
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Text(title, style: theme.textTheme.headlineLarge?.copyWith(color: theme.colorScheme.onPrimary)),
            ),
          ],
        ),
      ),
    );
  }
}
