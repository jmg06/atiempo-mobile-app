import 'package:atiempo_mobile_app/config/router/app_routes.dart';
import 'package:atiempo_mobile_app/features/alarm/presentation/widgets/system_note_card.dart';
import 'package:atiempo_mobile_app/features/alarm/presentation/widgets/system_surface_layout.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/icon_tone.dart';
import 'package:atiempo_mobile_app/shared/domain/scenario/restrepo_household.dart';
import 'package:atiempo_mobile_app/shared/presentation/icons/app_icons.dart';
import 'package:atiempo_mobile_app/shared/presentation/scope/dose_day_scope.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/actions/app_action_pair.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/surfaces/app_system_notice.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({super.key});

  static const Duration _confirmedAt = Duration(hours: 15, minutes: 17);

  void _confirm(BuildContext context) {
    DoseDayScope.read(context)
        .markGiven(RestrepoHousehold.afternoonBlockId, at: _confirmedAt, by: RestrepoHousehold.caregiver);
    context.push(AppRoutes.doseConfirmed);
  }

  @override
  Widget build(BuildContext context) {
    return SystemSurfaceLayout(
      time: '3:15',
      children: <Widget>[
        AppSystemNotice(
          icon: AppIcons.notificationsActive,
          iconTone: IconTone.attention,
          title: 'Es la hora',
          body: 'Samuel, bloque de la tarde. Anticonvulsivante 1 tableta entera y suplemento 5 gotas.',
          actions: AppActionPair(
            confirmLabel: 'YA LA DI',
            onConfirm: () => _confirm(context),
            delegateLabel: 'DELEGAR ESTA DOSIS',
            onDelegate: () => context.push(AppRoutes.delegateBlock(RestrepoHousehold.afternoonBlockId)),
          ),
        ),
        const SystemNoteCard(
          icon: AppIcons.recordVoiceOver,
          text: 'Lo dijo en voz alta: son las tres y cuarto, anticonvulsivante una tableta y suplemento cinco gotas.',
        ),
      ],
    );
  }
}
