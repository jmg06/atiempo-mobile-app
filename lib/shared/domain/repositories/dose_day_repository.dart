import 'package:atiempo_mobile_app/shared/domain/entities/dose_block.dart';
import 'package:flutter/foundation.dart';

abstract interface class DoseDayRepository implements Listenable {
  List<DoseBlock> get blocks;

  DoseBlock blockById(String id);

  void markGiven(String blockId, {required Duration at, required String by});

  void delegate(String blockId, {required String to, required Duration at});

  void reset();
}
