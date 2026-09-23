import 'package:atiempo_mobile_app/config/router/app_routes.dart';
import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:atiempo_mobile_app/features/day/presentation/block_copy.dart';
import 'package:atiempo_mobile_app/features/day/presentation/widgets/day_scaffold.dart';
import 'package:atiempo_mobile_app/shared/domain/entities/dose_block.dart';
import 'package:atiempo_mobile_app/shared/domain/entities/medication.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/dose_block_status.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/notice_band_kind.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/status_pill_kind.dart';
import 'package:atiempo_mobile_app/shared/domain/repositories/dose_day_repository.dart';
import 'package:atiempo_mobile_app/shared/domain/scenario/restrepo_household.dart';
import 'package:atiempo_mobile_app/shared/presentation/formatters/clock_formatter.dart';
import 'package:atiempo_mobile_app/shared/presentation/icons/app_icons.dart';
import 'package:atiempo_mobile_app/shared/presentation/mixins/simulated_request_mixin.dart';
import 'package:atiempo_mobile_app/shared/presentation/scope/dose_day_scope.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/actions/app_action_pair.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/chrome/app_screen_header.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/content/app_day_strip.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/content/app_medication_row.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/content/app_status_pill.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/layout/app_footnote.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/layout/app_section_card.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/surfaces/app_notice_band.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// One block, read from the day: what it brings, where it falls and what can still be done with it.
class BlockDetailScreen extends StatefulWidget {
  const BlockDetailScreen({required this.blockId, super.key});

  final String blockId;

  @override
  State<BlockDetailScreen> createState() => _BlockDetailScreenState();
}

class _BlockDetailScreenState extends State<BlockDetailScreen> with SimulatedRequestMixin<BlockDetailScreen> {
  static const String _date = 'martes 12 de agosto';
  static const String _contentsLabel = 'QUÉ TRAE ESTE BLOQUE';
  static const String _giverLabel = 'QUIÉN LA DIO';
  static const String _seeDayLabel = 'VER EL DÍA';
  static const String _confirmLabel = 'YA LA DI';
  static const String _delegateLabel = 'DELEGAR ESTA DOSIS';

  /// What the hour turns into once it is confirmed from here.
  static const Duration _confirmedAfter = Duration(minutes: 2);

  Future<void> _confirm(DoseBlock block) async {
    await simulateRequest(() async {
      DoseDayScope.read(context)
          .markGiven(block.id, at: block.scheduledAt + _confirmedAfter, by: RestrepoHousehold.caregiver);
      await context.push(AppRoutes.doseConfirmed);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final DoseDayRepository day = DoseDayScope.of(context);
    final List<DoseBlock> blocks = day.blocks;
    final DoseBlock block = day.blockById(widget.blockId);
    final bool isDone = block.status == DoseBlockStatus.done;
    final (StatusPillKind kind, String label) = _pill(block.status);

    return DayScaffold(
      header: AppScreenHeader(
        onBack: () => context.pop(),
        actionLabel: block.status == DoseBlockStatus.pending ? null : _seeDayLabel,
        onAction: () => context.go(AppRoutes.today),
      ),
      children: <Widget>[
        Row(
          spacing: AppDimens.space8,
          children: <Widget>[
            Expanded(child: Text(ClockFormatter.time(block.scheduledAt), style: theme.textTheme.headlineLarge)),
            AppStatusPill(kind: kind, label: label),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: Text(
            '${BlockCopy.moment(block.scheduledAt)} · ${RestrepoHousehold.patient}',
            style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
        ),
        AppDayStrip(
          blocks: <AppDayStripBlock>[
            for (final DoseBlock each in blocks)
              AppDayStripBlock(
                hour: each.scheduledAt.inMinutes / Duration.minutesPerHour,
                status: each.status,
                label: ClockFormatter.time(each.scheduledAt),
              ),
          ],
          focusedIndex: blocks.indexWhere((DoseBlock each) => each.id == block.id),
        ),
        _notice(block),
        AppSectionCard(
          label: _contentsLabel,
          children: <Widget>[
            for (final Medication medication in block.medications)
              AppMedicationRow(
                name: medication.name,
                amount: BlockCopy.amountWithInstructions(medication),
                form: medication.form,
              ),
          ],
        ),
        if (isDone) _giver(context, block),
        if (!isDone) _actions(block),
        AppFootnote(_footnote(block, blocks)),
      ],
    );
  }

  Widget _notice(DoseBlock block) {
    final Duration deadline = block.scheduledAt + BlockCopy.margin;
    final (NoticeBandKind kind, IconData icon, String text) = switch (block.status) {
      DoseBlockStatus.done => (NoticeBandKind.result, AppIcons.checkCircle, _given(block)),
      DoseBlockStatus.scheduled => (
        NoticeBandKind.info,
        AppIcons.alarm,
        'Suena a las ${ClockFormatter.time(block.scheduledAt)}, con margen hasta las '
            '${ClockFormatter.time(deadline)}',
      ),
      _ => (NoticeBandKind.attention, AppIcons.schedule, 'Hay margen hasta las ${ClockFormatter.time(deadline)}'),
    };

    return AppNoticeBand(kind: kind, icon: icon, text: text);
  }

  String _given(DoseBlock block) {
    final Duration givenAt = block.givenAt ?? block.scheduledAt;
    final String lateness = BlockCopy.lateness(block.scheduledAt, givenAt);

    return 'Se dio a las ${ClockFormatter.time(givenAt)}, $lateness después de la hora.';
  }

  Widget _giver(BuildContext context, DoseBlock block) {
    final ThemeData theme = Theme.of(context);
    final String name = block.givenBy ?? RestrepoHousehold.caregiver;

    return AppSectionCard(
      label: _giverLabel,
      spacing: 2,
      children: <Widget>[
        Text(name == RestrepoHousehold.caregiver ? '$name, que eres tú' : name, style: theme.textTheme.titleMedium),
        Text(_date, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
      ],
    );
  }

  Widget _actions(DoseBlock block) {
    final bool canConfirm = block.status != DoseBlockStatus.scheduled;

    return AppActionPair(
      confirmLabel: canConfirm ? _confirmLabel : null,
      onConfirm: canConfirm ? () => _confirm(block) : null,
      isConfirmWorking: isRequesting,
      delegateLabel: _delegateLabel,
      onDelegate: () => context.push(AppRoutes.delegateBlock(block.id)),
    );
  }

  String _footnote(DoseBlock block, List<DoseBlock> blocks) {
    return switch (block.status) {
      DoseBlockStatus.done => BlockCopy.closing(block, blocks, 'Este bloque ya quedó cerrado.'),
      DoseBlockStatus.scheduled =>
        'Todavía no se puede confirmar: la dosis se confirma cuando suene la alarma, desde la pantalla bloqueada.',
      _ => 'Se guarda en el teléfono aunque no haya señal, y sube cuando vuelva.',
    };
  }

  (StatusPillKind, String) _pill(DoseBlockStatus status) {
    return switch (status) {
      DoseBlockStatus.done => (StatusPillKind.done, 'CUMPLIDA'),
      DoseBlockStatus.scheduled => (StatusPillKind.scheduled, 'PROGRAMADA'),
      _ => (StatusPillKind.pending, 'PENDIENTE'),
    };
  }
}
