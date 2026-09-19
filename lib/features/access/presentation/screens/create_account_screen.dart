import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/notice_band_kind.dart';
import 'package:atiempo_mobile_app/shared/presentation/icons/app_icons.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/actions/app_primary_button.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/layout/app_access_scaffold.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/layout/app_section_card.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/surfaces/app_notice_band.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color muted = theme.colorScheme.onSurfaceVariant;

    return AppAccessScaffold(
      title: 'Crear la cuenta',
      onBack: () => context.pop(),
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.space16, vertical: AppDimens.space24),
      spacing: AppDimens.space20,
      children: <Widget>[
        Text(
          'Aquí en el teléfono se atienden las alarmas y se confirman las dosis. El tratamiento, el hogar y las '
          'personas se arman en el sitio, porque hay bastante que escribir.',
          style: theme.textTheme.bodyLarge,
        ),
        AppSectionCard(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.space16, vertical: AppDimens.space24),
          spacing: AppDimens.space8,
          children: <Widget>[
            _Centered('EN EL COMPUTADOR, ESCRIBE', style: theme.textTheme.labelMedium?.copyWith(color: muted)),
            _Centered('atiempo.app', style: theme.textTheme.headlineSmall?.copyWith(color: theme.colorScheme.primary)),
            _Centered(
              'En el navegador, con la misma cuenta de correo',
              style: theme.textTheme.bodyMedium?.copyWith(color: muted),
            ),
          ],
        ),
        const AppNoticeBand(
          kind: NoticeBandKind.info,
          icon: AppIcons.smartphone,
          text:
              'Si alguien del hogar te invitó, abre desde este teléfono el enlace que te llegó por mensaje o por '
              'correo.',
        ),
        AppPrimaryButton(label: 'VOLVER A ENTRAR', onPressed: () => context.pop()),
      ],
    );
  }
}

class _Centered extends StatelessWidget {
  const _Centered(this.text, {this.style});

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(text, textAlign: TextAlign.center, style: style),
    );
  }
}
