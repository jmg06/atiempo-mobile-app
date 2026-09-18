import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/headers/app_brand_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A stand-in for the phone's lock screen, which the product cannot draw for real.
class AppSystemBackdrop extends StatelessWidget {
  const AppSystemBackdrop({required this.time, required this.date, this.child, super.key});

  final String time;
  final String date;
  final Widget? child;

  static const Color _shapeTint = Color(0x12FFFFFF);
  static const double _clockTop = 60;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: SizedBox.expand(
        child: DecoratedBox(
          decoration: BoxDecoration(gradient: AppBrandGradient.backdrop(context)),
          child: Stack(
            children: <Widget>[
              const Positioned(left: 190, top: -140, child: _OrganicShape(size: 420)),
              const Positioned(left: -170, top: 610, child: _OrganicShape(size: 360)),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: AppDimens.space16, top: _clockTop),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    spacing: AppDimens.space4,
                    children: <Widget>[
                      Text(time, style: theme.textTheme.displayLarge?.copyWith(color: theme.colorScheme.onPrimary)),
                      Text(date, style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.primaryContainer)),
                    ],
                  ),
                ),
              ),
              if (child != null) Positioned.fill(child: SafeArea(child: child!)),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrganicShape extends StatelessWidget {
  const _OrganicShape({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(color: AppSystemBackdrop._shapeTint, shape: BoxShape.circle),
    );
  }
}
