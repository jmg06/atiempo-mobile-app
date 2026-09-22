import 'package:atiempo_mobile_app/shared/domain/entities/dose_block.dart';
import 'package:atiempo_mobile_app/shared/domain/entities/medication.dart';
import 'package:atiempo_mobile_app/shared/presentation/formatters/clock_formatter.dart';

/// The lines the day screens write out of the day itself.
abstract final class BlockCopy {
  /// How long after its hour a dose still counts.
  static const Duration margin = Duration(minutes: 30);

  /// How long the second caregiver has before the dose comes back.
  static const Duration delegationWindow = Duration(minutes: 10);

  static const List<String> _counts = <String>[
    'cero',
    'un',
    'dos',
    'tres',
    'cuatro',
    'cinco',
    'seis',
    'siete',
    'ocho',
    'nueve',
    'diez',
  ];

  static String moment(Duration scheduledAt) {
    final int hour = scheduledAt.inHours;

    if (hour < 11) {
      return 'Bloque de la mañana';
    }
    if (hour < 14) {
      return 'Bloque del mediodía';
    }
    if (hour < 18) {
      return 'Bloque de la tarde';
    }
    return 'Bloque de la noche';
  }

  /// `Anticonvulsivante y suplemento`.
  static String names(DoseBlock block) {
    return _join(<String>[for (final Medication each in block.medications) each.name]);
  }

  /// `1 tableta entera y 5 gotas`.
  static String amounts(DoseBlock block) {
    return _join(<String>[for (final Medication each in block.medications) each.amount]);
  }

  /// `Anticonvulsivante 1 tableta entera y suplemento 5 gotas`.
  static String summary(DoseBlock block) {
    return _join(<String>[for (final Medication each in block.medications) '${each.name} ${each.amount}']);
  }

  static String amountWithInstructions(Medication medication) {
    final String? instructions = medication.instructions;
    return instructions == null ? medication.amount : '${medication.amount}, $instructions';
  }

  static String firstName(String fullName) => fullName.split(' ').first;

  /// `dos minutos`, for how late the dose went down.
  static String lateness(Duration scheduledAt, Duration givenAt) {
    final int minutes = (givenAt - scheduledAt).inMinutes;
    final String count = minutes < _counts.length ? _counts[minutes] : '$minutes';
    return minutes == 1 ? '$count minuto' : '$count minutos';
  }

  /// [opening] on its own when nothing is left of the day, and with the next hour appended when something is.
  static String closing(DoseBlock block, List<DoseBlock> blocks, String opening) {
    for (final DoseBlock each in blocks) {
      if (each.scheduledAt > block.scheduledAt) {
        return '$opening Lo que sigue es el de las ${ClockFormatter.time(each.scheduledAt)}';
      }
    }
    return opening;
  }

  static String _join(List<String> parts) {
    return <String>[for (final (int index, String part) in parts.indexed) index == 0 ? part : _lowerFirst(part)]
        .join(' y ');
  }

  static String _lowerFirst(String text) => text[0].toLowerCase() + text.substring(1);
}
