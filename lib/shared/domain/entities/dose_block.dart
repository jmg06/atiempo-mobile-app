import 'package:atiempo_mobile_app/shared/domain/entities/medication.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/dose_block_status.dart';

class DoseBlock {
  const DoseBlock({
    required this.id,
    required this.scheduledAt,
    required this.medications,
    required this.status,
    this.givenAt,
    this.givenBy,
    this.delegatedTo,
    this.delegatedAt,
  });

  final String id;

  /// Time of day, counted from midnight, like every other `Duration` in the day.
  final Duration scheduledAt;
  final List<Medication> medications;
  final DoseBlockStatus status;
  final Duration? givenAt;
  final String? givenBy;
  final String? delegatedTo;
  final Duration? delegatedAt;

  DoseBlock copyWith({
    DoseBlockStatus? status,
    Duration? givenAt,
    String? givenBy,
    String? delegatedTo,
    Duration? delegatedAt,
  }) {
    return DoseBlock(
      id: id,
      scheduledAt: scheduledAt,
      medications: medications,
      status: status ?? this.status,
      givenAt: givenAt ?? this.givenAt,
      givenBy: givenBy ?? this.givenBy,
      delegatedTo: delegatedTo ?? this.delegatedTo,
      delegatedAt: delegatedAt ?? this.delegatedAt,
    );
  }
}
