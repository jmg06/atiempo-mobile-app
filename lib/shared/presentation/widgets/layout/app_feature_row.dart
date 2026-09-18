import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/icon_tone.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/content/app_product_icon.dart';
import 'package:flutter/material.dart';

class AppFeatureRow extends StatelessWidget {
  const AppFeatureRow({
    required this.icon,
    required this.text,
    this.tone = IconTone.ink,
    this.hasBadge = true,
    super.key,
  });

  final IconData icon;
  final String text;
  final IconTone tone;
  final bool hasBadge;

  static const double _badgeSize = 40;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Widget glyph = AppProductIcon(icon, tone: tone);

    return Row(
      crossAxisAlignment: hasBadge ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      spacing: hasBadge ? AppDimens.space12 : AppDimens.space8,
      children: <Widget>[
        if (hasBadge)
          Container(
            width: _badgeSize,
            height: _badgeSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(AppDimens.cornerMedium),
            ),
            child: glyph,
          )
        else
          glyph,
        Expanded(child: Text(text, style: theme.textTheme.bodyLarge)),
      ],
    );
  }
}
