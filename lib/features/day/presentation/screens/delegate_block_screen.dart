import 'package:atiempo_mobile_app/config/router/app_routes.dart';
import 'package:atiempo_mobile_app/features/day/presentation/block_copy.dart';
import 'package:atiempo_mobile_app/features/day/presentation/widgets/day_scaffold.dart';
import 'package:atiempo_mobile_app/shared/domain/entities/dose_block.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/notice_band_kind.dart';
import 'package:atiempo_mobile_app/shared/domain/scenario/restrepo_household.dart';
import 'package:atiempo_mobile_app/shared/presentation/formatters/clock_formatter.dart';
import 'package:atiempo_mobile_app/shared/presentation/icons/app_icons.dart';
import 'package:atiempo_mobile_app/shared/presentation/mixins/simulated_request_mixin.dart';
import 'package:atiempo_mobile_app/shared/presentation/scope/dose_day_scope.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/actions/app_primary_button.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/actions/app_text_button.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/chrome/app_screen_header.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/inputs/app_person_option_row.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/layout/app_footnote.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/layout/app_section_card.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/layout/app_section_label.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/surfaces/app_notice_band.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Who the dose goes to when the principal caregiver cannot give it.
class DelegateBlockScreen extends StatefulWidget {
  const DelegateBlockScreen({required this.blockId, super.key});

  final String blockId;

  @override
  State<DelegateBlockScreen> createState() => _DelegateBlockScreenState();
}

class _DelegateBlockScreenState extends State<DelegateBlockScreen> with SimulatedRequestMixin<DelegateBlockScreen> {
  static const String _title = 'Quién puede darla';
  static const String _peopleLabel = 'PERSONAS DEL HOGAR';
  static const String _role = 'Segunda cuidadora · Casa Restrepo';
  static const String _onlyOne = 'Por ahora el hogar admite un solo segundo cuidador. Se cambia desde el computador.';
  static const String _reach =
      'Le llega a su teléfono ahora mismo. Si no responde en 10 minutos, la dosis vuelve a ti.';
  static const String _sendLabel = 'PASARLE LA DOSIS';
  static const String _keepLabel = 'Mejor la doy yo';

  /// What the hour turns into once the dose is handed over.
  static const Duration _handedAfter = Duration(minutes: 1);

  String? _chosen = RestrepoHousehold.secondCaregiver;

  Future<void> _delegate(DoseBlock block) async {
    await simulateRequest(() async {
      DoseDayScope.read(context)
          .delegate(block.id, to: _chosen ?? RestrepoHousehold.secondCaregiver, at: block.scheduledAt + _handedAfter);
      await context.push(AppRoutes.blockDelegation(block.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final DoseBlock block = DoseDayScope.of(context).blockById(widget.blockId);

    return DayScaffold(
      header: AppScreenHeader(onBack: () => context.pop()),
      children: <Widget>[
        Text(_title, style: theme.textTheme.headlineLarge),
        AppSectionCard(
          spacing: 2,
          children: <Widget>[
            Text(ClockFormatter.time(block.scheduledAt), style: theme.textTheme.titleLarge),
            Text(
              BlockCopy.summary(block),
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ],
        ),
        const AppSectionLabel(_peopleLabel),
        RadioGroup<String>(
          groupValue: _chosen,
          onChanged: (String? value) => setState(() => _chosen = value),
          child: const AppPersonOptionRow<String>(
            value: RestrepoHousehold.secondCaregiver,
            name: RestrepoHousehold.secondCaregiver,
            role: _role,
          ),
        ),
        const AppFootnote(_onlyOne),
        const AppNoticeBand(kind: NoticeBandKind.info, icon: AppIcons.send, text: _reach),
        AppPrimaryButton(label: _sendLabel, onPressed: () => _delegate(block), isWorking: isRequesting),
        AppTextButton(label: _keepLabel, isFullWidth: false, onPressed: () => context.pop()),
      ],
    );
  }
}
