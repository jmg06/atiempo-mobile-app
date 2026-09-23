import 'package:atiempo_mobile_app/config/router/app_routes.dart';
import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:atiempo_mobile_app/features/day/presentation/block_copy.dart';
import 'package:atiempo_mobile_app/features/day/presentation/widgets/day_scaffold.dart';
import 'package:atiempo_mobile_app/shared/domain/entities/dose_block.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/dose_block_status.dart';
import 'package:atiempo_mobile_app/shared/domain/scenario/restrepo_household.dart';
import 'package:atiempo_mobile_app/shared/presentation/formatters/clock_formatter.dart';
import 'package:atiempo_mobile_app/shared/presentation/scope/dose_day_scope.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/content/app_dose_block_card.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/headers/app_gradient_header.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/layout/app_footnote.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/layout/app_section_label.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Where the whole treatment day lands: what is still coming, and what already happened.
class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  static const String _title = 'Hoy, martes 12';
  static const String _aheadLabel = 'HOY, MARTES 12 · LO QUE SIGUE';
  static const String _behindLabel = 'HOY, MARTES 12 · YA PASÓ';
  static const String _lastOfDay = ', el último del día';
  static const String _hint = 'Toca un bloque para ver qué trae y en qué quedó.';

  void _open(BuildContext context, DoseBlock block) {
    context.push(
      block.status == DoseBlockStatus.delegated ? AppRoutes.blockDelegation(block.id) : AppRoutes.blockDetail(block.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<DoseBlock> blocks = DoseDayScope.of(context).blocks;
    final List<DoseBlock> ahead = blocks.where((DoseBlock block) => block.status != DoseBlockStatus.done).toList();
    final List<DoseBlock> behind = blocks.reversed
        .where((DoseBlock block) => block.status == DoseBlockStatus.done)
        .toList();
    final List<DoseBlock> delegated = blocks
        .where((DoseBlock block) => block.status == DoseBlockStatus.delegated)
        .toList();

    return DayScaffold(
      spacing: AppDimens.space12,
      header: AppGradientHeader(
        title: _title,
        subtitle: _subtitle(blocks, delegated.length),
        progress: (blocks.length - ahead.length + delegated.length) / blocks.length,
      ),
      children: <Widget>[
        const AppSectionLabel(_aheadLabel),
        for (final DoseBlock block in ahead) _card(context, block, blocks.last),
        const AppSectionLabel(_behindLabel),
        for (final DoseBlock block in behind) _card(context, block, blocks.last),
        AppFootnote(delegated.isEmpty ? _hint : _waitingOn(delegated.first)),
      ],
    );
  }

  Widget _card(BuildContext context, DoseBlock block, DoseBlock lastOfDay) {
    final String amounts = BlockCopy.amounts(block);

    return AppDoseBlockCard(
      time: ClockFormatter.time(block.scheduledAt),
      status: block.status,
      medication: BlockCopy.names(block),
      dose: block.id == lastOfDay.id ? '$amounts$_lastOfDay' : amounts,
      note: _note(block),
      onTap: () => _open(context, block),
    );
  }

  String? _note(DoseBlock block) {
    return switch (block.status) {
      DoseBlockStatus.ringing => 'Está sonando ahora',
      DoseBlockStatus.done when block.givenAt != null => 'Se registró a las ${ClockFormatter.time(block.givenAt!)}',
      DoseBlockStatus.delegated when block.delegatedAt != null =>
        '${block.delegatedTo} la recibió a las ${ClockFormatter.time(block.delegatedAt!)}',
      _ => null,
    };
  }

  String _subtitle(List<DoseBlock> blocks, int delegated) {
    final int done = blocks.where((DoseBlock block) => block.status == DoseBlockStatus.done).length;

    return delegated == 0
        ? '${RestrepoHousehold.patient} · $done de ${blocks.length} bloques cumplidos'
        : '${RestrepoHousehold.patient} · $delegated bloque delegado, $done cumplidos';
  }

  String _waitingOn(DoseBlock block) {
    final String helper = BlockCopy.firstName(block.delegatedTo ?? RestrepoHousehold.secondCaregiver);
    final Duration deadline = (block.delegatedAt ?? block.scheduledAt) + BlockCopy.delegationWindow;

    return '$helper tiene hasta las ${ClockFormatter.time(deadline)} para confirmar. Si no responde, la dosis '
        'vuelve a ti.';
  }
}
