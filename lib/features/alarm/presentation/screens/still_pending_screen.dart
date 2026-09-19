import 'package:atiempo_mobile_app/config/router/app_routes.dart';
import 'package:atiempo_mobile_app/features/alarm/presentation/widgets/system_surface_layout.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/icon_tone.dart';
import 'package:atiempo_mobile_app/shared/domain/scenario/restrepo_household.dart';
import 'package:atiempo_mobile_app/shared/presentation/icons/app_icons.dart';
import 'package:atiempo_mobile_app/shared/presentation/scope/dose_day_scope.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/actions/app_action_pair.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/surfaces/app_system_notice.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StillPendingScreen extends StatelessWidget {
  const StillPendingScreen({super.key});

  static const Duration _now = Duration(hours: 15, minutes: 26);

  void _confirm(BuildContext context) {
    DoseDayScope.read(context).markGiven(RestrepoHousehold.afternoonBlockId, at: _now, by: RestrepoHousehold.caregiver);
    context.push(AppRoutes.doseConfirmed);
  }

  @override
  Widget build(BuildContext context) {
    return SystemSurfaceLayout(
      time: '3:26',
      bottomGap: 24,
      children: <Widget>[
        AppSystemNotice(
          icon: AppIcons.notificationsActive,
          iconTone: IconTone.attention,
          timestamp: 'hace 11 minutos',
          title: 'La dosis sigue pendiente',
          body: 'Quedan 19 minutos de margen. Vuelve a sonar cada 5 minutos hasta las 3:45 p. m.',
          actions: AppActionPair(
            confirmLabel: 'YA LA DI',
            onConfirm: () => _confirm(context),
            delegateLabel: 'DELEGAR ESTA DOSIS',
            onDelegate: () => context.push(AppRoutes.delegateBlock(RestrepoHousehold.afternoonBlockId)),
          ),
        ),
      ],
    );
  }
}
