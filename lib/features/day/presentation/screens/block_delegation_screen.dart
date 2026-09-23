import 'package:atiempo_mobile_app/config/router/app_routes.dart';
import 'package:atiempo_mobile_app/features/day/presentation/block_copy.dart';
import 'package:atiempo_mobile_app/features/day/presentation/widgets/day_scaffold.dart';
import 'package:atiempo_mobile_app/shared/domain/entities/dose_block.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/dose_block_status.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/icon_tone.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/notice_band_kind.dart';
import 'package:atiempo_mobile_app/shared/domain/repositories/dose_day_repository.dart';
import 'package:atiempo_mobile_app/shared/domain/scenario/restrepo_household.dart';
import 'package:atiempo_mobile_app/shared/presentation/formatters/clock_formatter.dart';
import 'package:atiempo_mobile_app/shared/presentation/icons/app_icons.dart';
import 'package:atiempo_mobile_app/shared/presentation/mixins/simulated_request_mixin.dart';
import 'package:atiempo_mobile_app/shared/presentation/scope/dose_day_scope.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/actions/app_primary_button.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/actions/app_secondary_button.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/chrome/app_screen_header.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/layout/app_footnote.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/layout/app_progress_step_row.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/layout/app_section_card.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/surfaces/app_notice_band.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// How a handed over dose is going, and how it ended once the second caregiver answered.
class BlockDelegationScreen extends StatefulWidget {
  const BlockDelegationScreen({required this.blockId, super.key});

  final String blockId;

  @override
  State<BlockDelegationScreen> createState() => _BlockDelegationScreenState();
}

class _BlockDelegationScreenState extends State<BlockDelegationScreen>
    with SimulatedRequestMixin<BlockDelegationScreen> {
  static const String _stepsLabel = 'CÓMO VA';
  static const String _cancelLabel = 'CANCELAR Y DARLA YO';
  static const String _seeDayLabel = 'VER EL DÍA';

  /// What the hand over turns into once the dose comes back and is given here.
  static const Duration _takenBackAfter = Duration(minutes: 1);

  Future<void> _takeOver(DoseBlock block, Duration handedAt) async {
    await simulateRequest(() async {
      DoseDayScope.read(context).markGiven(block.id, at: handedAt + _takenBackAfter, by: RestrepoHousehold.caregiver);
      await context.push(AppRoutes.doseConfirmed);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final DoseDayRepository day = DoseDayScope.of(context);
    final DoseBlock block = day.blockById(widget.blockId);
    final bool isGiven = block.status == DoseBlockStatus.done;
    final String helper = BlockCopy.firstName(block.delegatedTo ?? RestrepoHousehold.secondCaregiver);
    final Duration handedAt = block.delegatedAt ?? block.scheduledAt;

    return DayScaffold(
      header: AppScreenHeader(onBack: () => context.pop()),
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 2,
            children: <Widget>[
              Text(isGiven ? '$helper ya la dio' : 'Se la pasaste a $helper', style: theme.textTheme.headlineLarge),
              Text(
                isGiven ? 'Hace un momento' : 'Hace 1 minuto',
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
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
        if (isGiven)
          AppNoticeBand(
            kind: NoticeBandKind.result,
            icon: AppIcons.checkCircle,
            text:
                'Quedó registrada a las ${ClockFormatter.time(block.givenAt ?? handedAt)} '
                'La dio ${block.givenBy ?? RestrepoHousehold.secondCaregiver}.',
          ),
        AppSectionCard(
          label: _stepsLabel,
          children: <Widget>[
            AppProgressStepRow(
              icon: AppIcons.checkCircle,
              tone: IconTone.done,
              when: ClockFormatter.time(handedAt),
              what: 'Le pasaste la dosis a $helper',
            ),
            if (isGiven)
              AppProgressStepRow(
                icon: AppIcons.checkCircle,
                tone: IconTone.done,
                when: ClockFormatter.time(block.givenAt ?? handedAt),
                what: '$helper confirmó que ya la dio',
                isCurrent: true,
              )
            else ...<Widget>[
              AppProgressStepRow(
                icon: AppIcons.pending,
                tone: IconTone.ink,
                when: 'Ahora',
                what: 'Esperando que $helper confirme',
                isCurrent: true,
              ),
              AppProgressStepRow(
                icon: AppIcons.schedule,
                when: ClockFormatter.time(handedAt + BlockCopy.delegationWindow),
                what: 'Si no responde, la dosis vuelve a ti',
              ),
            ],
          ],
        ),
        if (isGiven)
          AppPrimaryButton(label: _seeDayLabel, onPressed: () => context.go(AppRoutes.today))
        else
          AppSecondaryButton(label: _cancelLabel, onPressed: () => _takeOver(block, handedAt)),
        AppFootnote(
          isGiven
              ? BlockCopy.closing(
                  block,
                  day.blocks,
                  'El bloque de las ${ClockFormatter.digits(block.scheduledAt)} queda cerrado.',
                )
              : 'Puedes cerrar la aplicación. Te avisamos en cuanto $helper confirme.',
        ),
      ],
    );
  }
}
