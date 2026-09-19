import 'package:atiempo_mobile_app/config/router/app_routes.dart';
import 'package:atiempo_mobile_app/features/alarm/presentation/widgets/system_note_card.dart';
import 'package:atiempo_mobile_app/features/alarm/presentation/widgets/system_surface_layout.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/icon_tone.dart';
import 'package:atiempo_mobile_app/shared/domain/scenario/restrepo_household.dart';
import 'package:atiempo_mobile_app/shared/presentation/icons/app_icons.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/actions/app_action_pair.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/surfaces/app_system_notice.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PreAlertScreen extends StatelessWidget {
  const PreAlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SystemSurfaceLayout(
      time: '3:00',
      bottomGap: 48,
      children: <Widget>[
        AppSystemNotice(
          icon: AppIcons.schedule,
          iconTone: IconTone.muted,
          title: 'Faltan 15 minutos',
          body: 'Bloque de la tarde, 3:15 p. m. Anticonvulsivante 1 tableta entera y suplemento 5 gotas.',
          actions: AppActionPair(
            confirmLabel: 'VER EL BLOQUE',
            onConfirm: () => context.push(AppRoutes.blockDetail(RestrepoHousehold.afternoonBlockId)),
          ),
        ),
        const SystemNoteCard(
          icon: AppIcons.recordVoiceOver,
          text: 'Lo dijo en voz alta: en quince minutos, anticonvulsivante una tableta y suplemento cinco gotas.',
        ),
      ],
    );
  }
}
