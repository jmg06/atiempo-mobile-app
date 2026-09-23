import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/chrome/app_status_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A fixed header over a body that scrolls on the page gradient.
class DayScaffold extends StatelessWidget {
  const DayScaffold({required this.header, required this.children, this.spacing = AppDimens.space16, super.key});

  final Widget header;
  final List<Widget> children;
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
              header,
              Expanded(
                child: SafeArea(
                  top: false,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppDimens.space16),
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
