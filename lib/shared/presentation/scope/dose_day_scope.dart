import 'package:atiempo_mobile_app/shared/domain/repositories/dose_day_repository.dart';
import 'package:flutter/widgets.dart';

class DoseDayScope extends InheritedNotifier<DoseDayRepository> {
  const DoseDayScope({required DoseDayRepository repository, required super.child, super.key})
    : super(notifier: repository);

  /// Rebuilds the caller whenever the day changes.
  static DoseDayRepository of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DoseDayScope>()!.notifier!;
  }

  /// For callbacks, which must not subscribe to changes.
  static DoseDayRepository read(BuildContext context) {
    return context.getInheritedWidgetOfExactType<DoseDayScope>()!.notifier!;
  }
}
