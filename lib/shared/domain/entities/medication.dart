import 'package:atiempo_mobile_app/shared/domain/enums/medication_form.dart';

class Medication {
  const Medication({required this.name, required this.amount, required this.form});

  final String name;
  final String amount;
  final MedicationForm form;
}
