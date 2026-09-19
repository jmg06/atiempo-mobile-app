import 'package:atiempo_mobile_app/shared/data/seeds/restrepo_day_seed.dart';
import 'package:atiempo_mobile_app/shared/domain/entities/dose_block.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/dose_block_status.dart';
import 'package:atiempo_mobile_app/shared/domain/repositories/dose_day_repository.dart';
import 'package:flutter/foundation.dart';

class InMemoryDoseDayRepository extends ChangeNotifier implements DoseDayRepository {
  InMemoryDoseDayRepository() : _blocks = RestrepoDaySeed.blocks();

  List<DoseBlock> _blocks;

  @override
  List<DoseBlock> get blocks => List<DoseBlock>.unmodifiable(_blocks);

  @override
  DoseBlock blockById(String id) => _blocks.firstWhere((DoseBlock block) => block.id == id);

  @override
  void markGiven(String blockId, {required Duration at, required String by}) {
    _update(blockId, (DoseBlock block) => block.copyWith(status: DoseBlockStatus.done, givenAt: at, givenBy: by));
  }

  @override
  void delegate(String blockId, {required String to, required Duration at}) {
    _update(
      blockId,
      (DoseBlock block) => block.copyWith(status: DoseBlockStatus.delegated, delegatedTo: to, delegatedAt: at),
    );
  }

  @override
  void reset() {
    _blocks = RestrepoDaySeed.blocks();
    notifyListeners();
  }

  void _update(String blockId, DoseBlock Function(DoseBlock block) change) {
    _blocks = <DoseBlock>[for (final DoseBlock block in _blocks) block.id == blockId ? change(block) : block];
    notifyListeners();
  }
}
