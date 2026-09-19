import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/chrome/app_status_bar_style.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/headers/app_access_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppAccessScaffold extends StatelessWidget {
  const AppAccessScaffold({
    required this.title,
    required this.children,
    this.onBack,
    this.padding = const EdgeInsets.all(AppDimens.space16),
    this.spacing = AppDimens.space16,
    super.key,
  });

  final String title;
  final List<Widget> children;
  final VoidCallback? onBack;
  final EdgeInsetsGeometry padding;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppStatusBarStyle.onSurface,
      child: Scaffold(
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[colors.surfaceContainer, colors.surface],
            ),
          ),
          child: Column(
            children: <Widget>[
              ColoredBox(
                color: colors.surface,
                child: SizedBox(width: double.infinity, height: MediaQuery.paddingOf(context).top),
              ),
              AppAccessHeader(title: title, onBack: onBack),
              Expanded(
                child: SafeArea(
                  top: false,
                  child: SingleChildScrollView(
                    padding: padding,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: spacing, children: children),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
