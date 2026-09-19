import 'package:atiempo_mobile_app/config/router/app_routes.dart';
import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/icon_tone.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/notice_band_kind.dart';
import 'package:atiempo_mobile_app/shared/presentation/icons/app_icons.dart';
import 'package:atiempo_mobile_app/shared/presentation/mixins/simulated_request_mixin.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/actions/app_primary_button.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/actions/app_text_button.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/content/app_product_icon.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/layout/app_access_scaffold.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/layout/app_feature_row.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/layout/app_initial_avatar.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/layout/app_section_card.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/surfaces/app_notice_band.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InvitationScreen extends StatefulWidget {
  const InvitationScreen({this.isExpired = false, super.key});

  final bool isExpired;

  @override
  State<InvitationScreen> createState() => _InvitationScreenState();
}

class _InvitationScreenState extends State<InvitationScreen> with SimulatedRequestMixin<InvitationScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isExpired = widget.isExpired;

    return AppAccessScaffold(
      title: 'Te invitaron a un hogar',
      spacing: isExpired ? AppDimens.space12 : AppDimens.space16,
      children: <Widget>[
        const _Inviter(),
        const AppSectionCard(
          label: 'LO QUE VAS A PODER HACER',
          spacing: AppDimens.space8,
          children: <Widget>[
            AppFeatureRow(
              icon: AppIcons.checkCircle,
              tone: IconTone.done,
              hasBadge: false,
              text: 'Ver los bloques del día y en qué estado va cada uno',
            ),
            AppFeatureRow(
              icon: AppIcons.checkCircle,
              tone: IconTone.done,
              hasBadge: false,
              text: 'Recibir en tu teléfono las dosis que Carlos te pase',
            ),
            AppFeatureRow(
              icon: AppIcons.checkCircle,
              tone: IconTone.done,
              hasBadge: false,
              text: 'Confirmar una dosis y que a él le llegue el acuse',
            ),
            AppFeatureRow(
              icon: AppIcons.close,
              tone: IconTone.attention,
              hasBadge: false,
              text: 'No vas a poder cambiar el esquema del tratamiento',
            ),
          ],
        ),
        if (isExpired) ...<Widget>[
          const AppNoticeBand(
            kind: NoticeBandKind.attention,
            icon: AppIcons.warning,
            text: 'Esta invitación venció el 28 de agosto. Pídele a Carlos Restrepo que te mande una nueva.',
          ),
          AppPrimaryButton(
            label: 'PEDIR UNA INVITACIÓN NUEVA',
            onPressed: () => simulateRequest(() => context.go(AppRoutes.invitation)),
            isWorking: isRequesting,
          ),
        ] else ...<Widget>[
          Row(
            spacing: AppDimens.space8,
            children: <Widget>[
              const AppProductIcon(AppIcons.schedule),
              Expanded(
                child: Text(
                  'Esta invitación vence el 28 de agosto.',
                  style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
              ),
            ],
          ),
          AppPrimaryButton(
            label: 'ACEPTAR LA INVITACIÓN',
            onPressed: () => simulateRequest(() => context.push(AppRoutes.activateAccess)),
            isWorking: isRequesting,
          ),
        ],
        AppTextButton(label: 'Ahora no', isFullWidth: false, onPressed: () => context.go(AppRoutes.welcome)),
      ],
    );
  }
}

class _Inviter extends StatelessWidget {
  const _Inviter();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AppSectionCard(
      children: <Widget>[
        Row(
          spacing: AppDimens.space12,
          children: <Widget>[
            const AppInitialAvatar('C'),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 2,
                children: <Widget>[
                  Text('Carlos Restrepo', style: theme.textTheme.titleMedium),
                  Text(
                    'Cuidador principal de Casa Restrepo',
                    style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
