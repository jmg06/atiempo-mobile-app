import 'package:atiempo_mobile_app/shared/data/repositories/in_memory_dose_day_repository.dart';
import 'package:atiempo_mobile_app/shared/domain/entities/dose_block.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/dose_block_status.dart';
import 'package:atiempo_mobile_app/shared/domain/scenario/restrepo_household.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const String afternoon = RestrepoHousehold.afternoonBlockId;
  late InMemoryDoseDayRepository day;
  late int notifications;

  setUp(() {
    day = InMemoryDoseDayRepository();
    notifications = 0;
    day.addListener(() => notifications++);
  });

  test('starts on the mockup day, with the 3:15 block still pending', () {
    expect(day.blocks.map((DoseBlock block) => block.status), <DoseBlockStatus>[
      DoseBlockStatus.done,
      DoseBlockStatus.done,
      DoseBlockStatus.pending,
      DoseBlockStatus.scheduled,
      DoseBlockStatus.scheduled,
    ]);
  });

  test('markGiven records who gave the dose and when, and notifies', () {
    day.markGiven(afternoon, at: const Duration(hours: 15, minutes: 17), by: RestrepoHousehold.caregiver);

    final DoseBlock block = day.blockById(afternoon);
    expect(block.status, DoseBlockStatus.done);
    expect(block.givenAt, const Duration(hours: 15, minutes: 17));
    expect(block.givenBy, RestrepoHousehold.caregiver);
    expect(notifications, 1);
  });

  test('delegate hands the block over and leaves the others alone', () {
    day.delegate(afternoon, to: RestrepoHousehold.secondCaregiver, at: const Duration(hours: 15, minutes: 16));

    final DoseBlock block = day.blockById(afternoon);
    expect(block.status, DoseBlockStatus.delegated);
    expect(block.delegatedTo, RestrepoHousehold.secondCaregiver);
    expect(day.blockById(RestrepoHousehold.eveningBlockId).status, DoseBlockStatus.scheduled);
  });

  test('reset puts the day back as it was seeded', () {
    day.markGiven(afternoon, at: const Duration(hours: 15, minutes: 26), by: RestrepoHousehold.caregiver);
    day.reset();

    final DoseBlock block = day.blockById(afternoon);
    expect(block.status, DoseBlockStatus.pending);
    expect(block.givenAt, isNull);
    expect(notifications, 2);
  });

  test('blocks cannot be edited from outside', () {
    expect(() => day.blocks.clear(), throwsUnsupportedError);
  });
}
