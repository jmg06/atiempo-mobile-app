import 'package:atiempo_mobile_app/config/router/app_routes.dart';
import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/notice_band_kind.dart';
import 'package:atiempo_mobile_app/shared/presentation/icons/app_icons.dart';
import 'package:atiempo_mobile_app/shared/presentation/mixins/simulated_request_mixin.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/actions/app_primary_button.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/actions/app_text_button.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/inputs/app_checkbox.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/layout/app_access_scaffold.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/layout/app_feature_row.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/layout/app_section_card.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/surfaces/app_dialog.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/surfaces/app_notice_band.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConsentScreen extends StatefulWidget {
  const ConsentScreen({super.key});

  @override
  State<ConsentScreen> createState() => _ConsentScreenState();
}

class _ConsentScreenState extends State<ConsentScreen> with SimulatedRequestMixin<ConsentScreen> {
  bool _isAuthorized = true;

  Future<void> _confirmExit() async {
    final bool? leaves = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) => AppDialog(
        title: '¿Salir sin dar el permiso?',
        message: 'Sin este permiso no podemos programar las alarmas de Samuel. Puedes volver y darlo cuando quieras.',
        dismissLabel: 'VOLVER',
        onDismiss: () => Navigator.of(dialogContext).pop(false),
        confirmLabel: 'SALIR',
        onConfirm: () => Navigator.of(dialogContext).pop(true),
      ),
    );

    if ((leaves ?? false) && mounted) {
      context.go(AppRoutes.welcome);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AppAccessScaffold(
      title: 'Tus datos de salud',
      children: <Widget>[
        const AppNoticeBand(
          kind: NoticeBandKind.info,
          icon: AppIcons.lock,
          text: 'Ya diste este permiso en el computador. Aquí lo confirmas para este teléfono.',
        ),
        Text('Esto es lo que pasa con la información de salud.', style: theme.textTheme.bodyLarge),
        const AppSectionCard(
          padding: EdgeInsets.all(AppDimens.space16),
          spacing: AppDimens.space16,
          children: <Widget>[
            AppFeatureRow(
              icon: AppIcons.medication,
              text: 'Qué guardamos',
              detail: 'Los medicamentos del tratamiento, sus horas, y a qué hora se dio cada dosis.',
            ),
            AppFeatureRow(
              icon: AppIcons.person,
              text: 'Con quién se comparte',
              detail: 'Solo con las personas que agregues al hogar. Con nadie más, ni con la EPS.',
            ),
            AppFeatureRow(
              icon: AppIcons.schedule,
              text: 'Hasta cuándo',
              detail: 'Hasta que nos pidas borrarlo. Se pide por correo a hola@atiempo.app.',
            ),
          ],
        ),
        AppCheckbox(
          value: _isAuthorized,
          label: 'Autorizo el tratamiento de mis datos de salud y los de la persona a mi cargo.',
          onChanged: (bool value) => setState(() => _isAuthorized = value),
        ),
        AppTextButton(label: 'Leer la política completa', isFullWidth: false, onPressed: () {}),
        AppPrimaryButton(
          label: 'ACEPTO Y CONTINUO',
          onPressed: _isAuthorized ? () => simulateRequest(() => context.go(AppRoutes.today)) : null,
          isWorking: isRequesting,
        ),
        AppTextButton(label: 'No acepto', isFullWidth: false, onPressed: _confirmExit),
      ],
    );
  }
}
