import 'package:atiempo_mobile_app/config/router/app_routes.dart';
import 'package:atiempo_mobile_app/features/alarm/presentation/widgets/system_note_card.dart';
import 'package:atiempo_mobile_app/features/alarm/presentation/widgets/system_surface_layout.dart';
import 'package:atiempo_mobile_app/shared/domain/entities/dose_block.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/icon_tone.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/notice_band_kind.dart';
import 'package:atiempo_mobile_app/shared/domain/scenario/restrepo_household.dart';
import 'package:atiempo_mobile_app/shared/presentation/formatters/clock_formatter.dart';
import 'package:atiempo_mobile_app/shared/presentation/icons/app_icons.dart';
import 'package:atiempo_mobile_app/shared/presentation/scope/dose_day_scope.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/actions/app_action_pair.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/surfaces/app_notice_band.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/surfaces/app_system_notice.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DoseConfirmedScreen extends StatelessWidget {
  const DoseConfirmedScreen({this.isOffline = false, super.key});

  final bool isOffline;

  static const Duration _fallbackTime = Duration(hours: 15, minutes: 17);

  @override
  Widget build(BuildContext context) {
    final DoseBlock block = DoseDayScope.of(context).blockById(RestrepoHousehold.afternoonBlockId);
    final Duration givenAt = block.givenAt ?? _fallbackTime;
    final String time = ClockFormatter.time(givenAt);

    return SystemSurfaceLayout(
      time: ClockFormatter.digits(givenAt),
      children: <Widget>[
        AppSystemNotice(
          icon: AppIcons.checkCircle,
          iconTone: IconTone.done,
          title: isOffline ? 'Quedó marcada en el teléfono' : 'Quedó registrada',
          body: isOffline
              ? 'Se marcó a las $time Sube en cuanto vuelva la señal.'
              : 'Se registró a las $time Marta Restrepo ya lo sabe.',
          actions: AppActionPair(confirmLabel: 'VER EL DÍA', onConfirm: () => context.go(AppRoutes.today)),
        ),
        if (isOffline)
          const AppNoticeBand(
            kind: NoticeBandKind.attention,
            icon: AppIcons.wifiOff,
            text:
                'Sin conexión. No se pierde nada: la dosis ya quedó marcada aquí, y Marta Restrepo lo sabrá cuando '
                'suba.',
          )
        else
          const SystemNoteCard(
            icon: AppIcons.checkCircle,
            text: 'La alarma se apagó sola en el mismo acto, sin abrir la aplicación.',
          ),
      ],
    );
  }
}
