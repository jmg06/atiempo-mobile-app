import 'package:atiempo_mobile_app/shared/domain/enums/medication_form.dart';

class Medication {
  const Medication({required this.name, required this.amount, required this.form, this.instructions});

  final String name;
  final String amount;
  final MedicationForm form;

  /// How it goes down, which only the block detail spells out.
  final String? instructions;
}
