import 'package:atiempo_mobile_app/config/router/app_routes.dart';
import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:atiempo_mobile_app/shared/domain/repositories/dose_day_repository.dart';
import 'package:atiempo_mobile_app/shared/domain/scenario/restrepo_household.dart';
import 'package:atiempo_mobile_app/shared/presentation/icons/app_icons.dart';
import 'package:atiempo_mobile_app/shared/presentation/scope/dose_day_scope.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/content/app_product_icon.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/layout/app_access_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FlowsScreen extends StatelessWidget {
  const FlowsScreen({super.key});

  static const Duration _confirmedAt = Duration(hours: 15, minutes: 17);

  static final List<_Flow> _flows = <_Flow>[
    const _Flow(
      title: 'La alarma y la confirmación de la dosis',
      startsAt: 'Flujo principal. Empieza cuando suena la alarma',
      route: AppRoutes.alarm,
    ),
    _Flow(
      title: 'Entrar y ver el día',
      startsAt: 'Empieza en la bienvenida',
      route: AppRoutes.welcome,
      prepare: (DoseDayRepository day) =>
          day.markGiven(RestrepoHousehold.afternoonBlockId, at: _confirmedAt, by: RestrepoHousehold.caregiver),
    ),
    const _Flow(title: 'La invitación al hogar', startsAt: 'Empieza en la invitación', route: AppRoutes.invitation),
    const _Flow(title: 'El pre aviso hablado', startsAt: 'Empieza 15 minutos antes', route: AppRoutes.preAlert),
    _Flow(
      title: 'La dosis delegada, en el otro teléfono',
      startsAt: 'Empieza en el teléfono de Marta',
      route: AppRoutes.delegatedDose,
      prepare: (DoseDayRepository day) => day.delegate(
        RestrepoHousehold.afternoonBlockId,
        to: RestrepoHousehold.secondCaregiver,
        at: const Duration(hours: 15, minutes: 16),
      ),
    ),
    const _Flow(title: 'Nadie respondió a la alarma', startsAt: 'Camino de error', route: AppRoutes.stillPending),
    _Flow(
      title: 'Se confirmó sin conexión',
      startsAt: 'Camino de error',
      route: AppRoutes.doseConfirmedOffline,
      prepare: (DoseDayRepository day) =>
          day.markGiven(RestrepoHousehold.afternoonBlockId, at: _confirmedAt, by: RestrepoHousehold.caregiver),
    ),
    const _Flow(title: 'La invitación venció', startsAt: 'Camino de error', route: AppRoutes.expiredInvitation),
  ];

  void _start(BuildContext context, _Flow flow) {
    final DoseDayRepository day = DoseDayScope.read(context)..reset();
    flow.prepare?.call(day);
    context.push(flow.route);
  }

  @override
  Widget build(BuildContext context) {
    return AppAccessScaffold(
      title: 'Por dónde empezar',
      spacing: AppDimens.space12,
      children: <Widget>[for (final _Flow flow in _flows) _FlowTile(flow: flow, onTap: () => _start(context, flow))],
    );
  }
}

class _Flow {
  const _Flow({required this.title, required this.startsAt, required this.route, this.prepare});

  final String title;
  final String startsAt;
  final String route;
  final void Function(DoseDayRepository day)? prepare;
}

class _FlowTile extends StatelessWidget {
  const _FlowTile({required this.flow, required this.onTap});

  final _Flow flow;
  final VoidCallback onTap;

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
          padding: const EdgeInsets.all(AppDimens.space16),
          child: Row(
            spacing: AppDimens.space12,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: <Widget>[
                    Text(flow.title, style: theme.textTheme.titleMedium),
                    Text(
                      flow.startsAt,
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              const AppProductIcon(AppIcons.chevronRight),
            ],
          ),
        ),
      ),
    );
  }
}
