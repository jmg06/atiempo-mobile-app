import 'package:atiempo_mobile_app/config/theme/app_dimens.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/dose_block_status.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/icon_tone.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/status_pill_kind.dart';
import 'package:atiempo_mobile_app/shared/presentation/icons/app_icons.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/content/app_product_icon.dart';
import 'package:atiempo_mobile_app/shared/presentation/widgets/content/app_status_pill.dart';
import 'package:flutter/material.dart';

class AppDoseBlockCard extends StatelessWidget {
  const AppDoseBlockCard({
    required this.time,
    required this.status,
    required this.medication,
    required this.dose,
    this.note,
    this.statusLabel,
    this.onTap,
    super.key,
  });

  final String time;
  final DoseBlockStatus status;
  final String medication;
  final String dose;
  final String? note;
  final String? statusLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final (IconData? icon, IconTone tone, StatusPillKind pill, String label) = _status;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.cornerMedium),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppDimens.cornerMedium),
          border: Border.all(color: theme.colorScheme.outlineVariant),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.space16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: AppDimens.space8,
            children: <Widget>[
              Row(
                spacing: AppDimens.space12,
                children: <Widget>[
                  if (icon != null) AppProductIcon(icon, tone: tone),
                  Expanded(child: Text(time, style: theme.textTheme.titleLarge)),
                  AppStatusPill(kind: pill, label: statusLabel ?? label),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: Text(medication, style: theme.textTheme.titleMedium),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  dose,
                  style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
              ),
              if (note != null)
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    note!,
                    style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  (IconData?, IconTone, StatusPillKind, String) get _status {
    return switch (status) {
      DoseBlockStatus.scheduled => (null, IconTone.ink, StatusPillKind.scheduled, 'PROGRAMADA'),
      DoseBlockStatus.pending => (AppIcons.pending, IconTone.attention, StatusPillKind.pending, 'PENDIENTE'),
      DoseBlockStatus.ringing => (AppIcons.notificationsActive, IconTone.attention, StatusPillKind.pending, 'SONANDO'),
      DoseBlockStatus.done => (AppIcons.checkCircle, IconTone.done, StatusPillKind.done, 'CUMPLIDA'),
      DoseBlockStatus.delegated => (AppIcons.send, IconTone.ink, StatusPillKind.delegated, 'DELEGADA'),
    };
  }
}
