import 'package:atiempo_mobile_app/shared/domain/entities/dose_block.dart';
import 'package:atiempo_mobile_app/shared/domain/entities/medication.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/dose_block_status.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/medication_form.dart';
import 'package:atiempo_mobile_app/shared/domain/scenario/restrepo_household.dart';

/// Tuesday the 12th as it stands a few minutes before the 3:15 p. m. alarm.
abstract final class RestrepoDaySeed {
  static const Medication _anticonvulsant = Medication(
    name: 'Anticonvulsivante',
    amount: '1 tableta entera',
    form: MedicationForm.solid,
    instructions: 'con agua',
  );
  static const Medication _antidepressant = Medication(
    name: 'Antidepresivo',
    amount: 'Media tableta',
    form: MedicationForm.solid,
  );
  static const Medication _supplement = Medication(
    name: 'Suplemento',
    amount: '5 gotas',
    form: MedicationForm.liquid,
    instructions: 'con el gotero',
  );

  static List<DoseBlock> blocks() {
    return const <DoseBlock>[
      DoseBlock(
        id: RestrepoHousehold.morningBlockId,
        scheduledAt: Duration(hours: 7, minutes: 15),
        medications: <Medication>[_anticonvulsant, _supplement],
        status: DoseBlockStatus.done,
        givenAt: Duration(hours: 7, minutes: 18),
        givenBy: RestrepoHousehold.caregiver,
      ),
      DoseBlock(
        id: RestrepoHousehold.middayBlockId,
        scheduledAt: Duration(hours: 11),
        medications: <Medication>[_antidepressant],
        status: DoseBlockStatus.done,
        givenAt: Duration(hours: 11, minutes: 5),
        givenBy: RestrepoHousehold.caregiver,
      ),
      DoseBlock(
        id: RestrepoHousehold.afternoonBlockId,
        scheduledAt: Duration(hours: 15, minutes: 15),
        medications: <Medication>[_anticonvulsant, _supplement],
        status: DoseBlockStatus.pending,
      ),
      DoseBlock(
        id: RestrepoHousehold.eveningBlockId,
        scheduledAt: Duration(hours: 19),
        medications: <Medication>[_antidepressant, _supplement],
        status: DoseBlockStatus.scheduled,
      ),
      DoseBlock(
        id: RestrepoHousehold.nightBlockId,
        scheduledAt: Duration(hours: 23, minutes: 30),
        medications: <Medication>[_anticonvulsant],
        status: DoseBlockStatus.scheduled,
      ),
    ];
  }
}
