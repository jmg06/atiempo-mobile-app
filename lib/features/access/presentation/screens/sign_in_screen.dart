import 'package:atiempo_mobile_app/config/router/app_routes.dart';
import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:atiempo_mobile_app/features/access/domain/validators/credential_validator.dart';
import 'package:atiempo_mobile_app/features/access/presentation/credential_failure_message.dart';
import 'package:atiempo_mobile_app/features/access/presentation/widgets/fingerprint_card.dart';
import 'package:atiempo_mobile_app/shared/presentation/mixins/simulated_request_mixin.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/actions/app_primary_button.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/actions/app_text_button.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/inputs/app_text_field.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/layout/app_access_scaffold.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/layout/app_footnote.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/layout/app_or_divider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with SimulatedRequestMixin<SignInScreen> {
  final TextEditingController _email = TextEditingController(text: 'carlos.restrepo@correo.com');
  final TextEditingController _password = TextEditingController(text: 'restrepo');
  bool _hasSubmitted = false;

  CredentialFailure? get _emailFailure => CredentialValidator.email(_email.text);

  CredentialFailure? get _passwordFailure => CredentialValidator.password(_password.text);

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _hasSubmitted = true);
    if (_emailFailure == null && _passwordFailure == null) {
      await simulateRequest(() => context.push(AppRoutes.consent));
    }
  }

  void _revalidate(String _) {
    if (_hasSubmitted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppAccessScaffold(
      title: 'Entra a tu cuenta',
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.space16, vertical: AppDimens.space24),
      children: <Widget>[
        FingerprintCard(onTap: () => context.push(AppRoutes.consent)),
        const AppOrDivider(),
        AppTextField(
          label: 'Correo electrónico',
          controller: _email,
          keyboardType: TextInputType.emailAddress,
          errorText: _hasSubmitted ? _emailFailure?.message : null,
          onChanged: _revalidate,
        ),
        AppTextField(
          label: 'Clave',
          controller: _password,
          isObscured: true,
          errorText: _hasSubmitted ? _passwordFailure?.message : null,
          onChanged: _revalidate,
        ),
        AppPrimaryButton(label: 'ENTRAR', onPressed: _submit, isWorking: isRequesting),
        AppTextButton(
          label: 'No tengo cuenta todavía',
          isFullWidth: false,
          onPressed: () => context.push(AppRoutes.createAccount),
        ),
        const AppFootnote(
          'Si es la primera vez en este teléfono, usa el correo y la clave. Después entras con la huella.',
        ),
      ],
    );
  }
}
