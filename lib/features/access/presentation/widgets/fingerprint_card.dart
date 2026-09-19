import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:atiempo_mobile_app/shared/presentation/icons/app_icons.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/content/app_product_icon.dart';
import 'package:flutter/material.dart';

class FingerprintCard extends StatelessWidget {
  const FingerprintCard({required this.onTap, super.key});

  final VoidCallback onTap;

  static const double _markSize = 72;
  static const double _glyphSize = 38.4;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surfaceContainerLowest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.cornerLarge),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.space16, vertical: AppDimens.space24),
          child: Column(
            spacing: AppDimens.space12,
            children: <Widget>[
              Container(
                width: _markSize,
                height: _markSize,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: theme.colorScheme.primaryContainer, shape: BoxShape.circle),
                child: const AppProductIcon(AppIcons.fingerprint, size: _glyphSize),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Toca la huella para entrar',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
