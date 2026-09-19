import 'package:atiempo_mobile_app/config/router/app_routes.dart';
import 'package:atiempo_mobile_app/features/access/domain/validators/credential_validator.dart';
import 'package:atiempo_mobile_app/features/access/presentation/credential_failure_message.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/notice_band_kind.dart';
import 'package:atiempo_mobile_app/shared/presentation/icons/app_icons.dart';
import 'package:atiempo_mobile_app/shared/presentation/mixins/simulated_request_mixin.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/actions/app_primary_button.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/inputs/app_checkbox.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/inputs/app_text_field.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/layout/app_access_scaffold.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/layout/app_footnote.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/layout/app_section_card.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/surfaces/app_notice_band.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ActivateAccessScreen extends StatefulWidget {
  const ActivateAccessScreen({super.key});

  @override
  State<ActivateAccessScreen> createState() => _ActivateAccessScreenState();
}

class _ActivateAccessScreenState extends State<ActivateAccessScreen> with SimulatedRequestMixin<ActivateAccessScreen> {
  final TextEditingController _password = TextEditingController(text: 'marta123');
  bool _wantsFingerprint = true;
  bool _hasSubmitted = false;

  CredentialFailure? get _passwordFailure => CredentialValidator.newPassword(_password.text);

  @override
  void dispose() {
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _hasSubmitted = true);
    if (_passwordFailure == null) {
      await simulateRequest(() => context.push(AppRoutes.consent));
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AppAccessScaffold(
      title: 'Crea tu clave',
      children: <Widget>[
        const AppNoticeBand(
          kind: NoticeBandKind.info,
          icon: AppIcons.home,
          text: 'Carlos Restrepo te invitó al hogar Casa Restrepo. Tu nombre y tu correo llegaron con la invitación.',
        ),
        Text('Es lo único que falta para entrar desde este teléfono.', style: theme.textTheme.bodyLarge),
        AppSectionCard(
          label: 'TE INVITARON COMO',
          spacing: 2,
          children: <Widget>[
            Text('Marta Restrepo', style: theme.textTheme.titleMedium),
            Text(
              'marta.restrepo@correo.com',
              style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ],
        ),
        AppTextField(
          label: 'Clave',
          controller: _password,
          isObscured: true,
          supportingText: CredentialFailure.shortPassword.message,
          errorText: _hasSubmitted ? _passwordFailure?.message : null,
          onChanged: (_) {
            if (_hasSubmitted) {
              setState(() {});
            }
          },
        ),
        AppCheckbox(
          value: _wantsFingerprint,
          label: 'Quiero entrar con la huella en este teléfono',
          labelAlignment: CrossAxisAlignment.center,
          onChanged: (bool value) => setState(() => _wantsFingerprint = value),
        ),
        AppPrimaryButton(label: 'CREAR MI CLAVE Y ENTRAR', onPressed: _submit, isWorking: isRequesting),
        const AppFootnote('Después te pedimos el permiso de datos de salud, una sola vez en este teléfono.'),
      ],
    );
  }
}
