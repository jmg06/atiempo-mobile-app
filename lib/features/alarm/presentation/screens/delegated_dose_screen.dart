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

/// On the second caregiver's phone. Whatever is answered here shows next on the principal caregiver's phone.
class DelegatedDoseScreen extends StatelessWidget {
  const DelegatedDoseScreen({super.key});

  static const Duration _givenAt = Duration(hours: 15, minutes: 22);

  static String get _delegation => AppRoutes.blockDelegation(RestrepoHousehold.afternoonBlockId);

  void _confirm(BuildContext context) {
    DoseDayScope.read(context)
        .markGiven(RestrepoHousehold.afternoonBlockId, at: _givenAt, by: RestrepoHousehold.secondCaregiver);
    context.push(_delegation);
  }

  @override
  Widget build(BuildContext context) {
    return SystemSurfaceLayout(
      time: '3:16',
      children: <Widget>[
        AppSystemNotice(
          icon: AppIcons.send,
          iconTone: IconTone.delegated,
          title: 'Te pasaron una dosis',
          body:
              'Carlos Restrepo te pasó el bloque de las 3:15 p. m., para Samuel. Anticonvulsivante 1 tableta entera '
              'y suplemento 5 gotas.',
          actions: AppActionPair(
            confirmLabel: 'YA LA DI',
            onConfirm: () => _confirm(context),
            delegateLabel: 'No puedo darla',
            onDelegate: () => context.push(_delegation),
          ),
        ),
        const SystemNoteCard(
          icon: AppIcons.schedule,
          text: 'Hay margen hasta las 3:45 p. m. Si no respondes antes de las 3:26, la dosis vuelve a Carlos.',
        ),
      ],
    );
  }
}
