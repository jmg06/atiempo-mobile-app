import 'package:atiempo_mobile_app/config/theme/app_colors.dart';
import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/notice_band_kind.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/content/app_product_icon.dart';
import 'package:flutter/material.dart';

class AppNoticeBand extends StatelessWidget {
  const AppNoticeBand({required this.kind, required this.icon, required this.text, super.key});

  final NoticeBandKind kind;
  final IconData icon;
  final String text;

  static const double _attentionBorderWidth = 2;
  static const double _verticalPadding = 14;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final (Color container, Color onContainer) = _colors(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.space16, vertical: _verticalPadding),
      decoration: BoxDecoration(
        color: container,
        borderRadius: BorderRadius.circular(AppDimens.cornerMedium),
        border: kind == NoticeBandKind.attention
            ? Border.all(color: context.appColors.statePending, width: _attentionBorderWidth)
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppDimens.space12,
        children: <Widget>[
          AppProductIcon(icon, color: onContainer),
          Expanded(
            child: Text(text, style: theme.textTheme.bodyLarge?.copyWith(color: onContainer)),
          ),
        ],
      ),
    );
  }

  (Color, Color) _colors(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final AppColors colors = context.appColors;

    return switch (kind) {
      NoticeBandKind.info => (scheme.surfaceContainer, scheme.onSurface),
      NoticeBandKind.attention => (colors.statePendingContainer, colors.onStatePendingContainer),
      NoticeBandKind.result => (colors.stateDoneContainer, colors.onStateDoneContainer),
    };
  }
}
