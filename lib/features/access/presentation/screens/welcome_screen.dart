import 'package:atiempo_mobile_app/config/router/app_routes.dart';
import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/notice_band_kind.dart';
import 'package:atiempo_mobile_app/shared/presentation/icons/app_icons.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/actions/app_primary_button.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/actions/app_text_button.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/layout/app_access_scaffold.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/layout/app_feature_row.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/layout/app_section_card.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/surfaces/app_notice_band.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppAccessScaffold(
      title: 'Alarmas que dicen cuál medicamento y qué dosis.',
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.space16, vertical: AppDimens.space24),
      spacing: AppDimens.space24,
      children: <Widget>[
        const AppSectionCard(
          label: 'LO QUE HACE LA APLICACIÓN',
          padding: EdgeInsets.all(AppDimens.space16),
          children: <Widget>[
            AppFeatureRow(icon: AppIcons.alarm, text: 'Suena aunque el teléfono esté en silencio'),
            AppFeatureRow(icon: AppIcons.checkCircle, text: 'Confirmas la toma sin abrir la aplicación'),
            AppFeatureRow(icon: AppIcons.person, text: 'Delegas una dosis cuando no estás en casa'),
          ],
        ),
        const AppNoticeBand(
          kind: NoticeBandKind.info,
          icon: AppIcons.lock,
          text: 'Vamos a manejar datos de salud. Antes de pedirte nada, te explicamos cuáles y para qué.',
        ),
        AppPrimaryButton(label: 'EMPEZAR', onPressed: () => context.push(AppRoutes.signIn)),
        AppTextButton(label: 'Ya tengo cuenta', isFullWidth: false, onPressed: () => context.push(AppRoutes.signIn)),
      ],
    );
  }
}
