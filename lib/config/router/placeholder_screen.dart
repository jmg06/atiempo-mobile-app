import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/chrome/app_screen_header.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/chrome/app_status_bar_style.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/layout/app_footnote.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

/// Stands in for a screen the other half of the pair has not built yet.
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppStatusBarStyle.onSurface,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppScreenHeader(onBack: () => context.pop()),
              Padding(
                padding: const EdgeInsets.all(AppDimens.space16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppDimens.space8,
                  children: <Widget>[
                    Text(title, style: theme.textTheme.headlineLarge),
                    const AppFootnote('Pantalla en construcción.'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
