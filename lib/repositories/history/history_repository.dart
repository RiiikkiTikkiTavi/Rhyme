import 'package:hive_ce/hive.dart';
import 'package:rhyme/repositories/history/history.dart';

class HistoryRepository implements HistoryRepositoryInterface {
  final Box<HistoryRhymes> rhymesBox;

  HistoryRepository({required this.rhymesBox});

  @override
  Future<List<HistoryRhymes>> getRhymesList() async {
    return rhymesBox.values.toList();
  }

  @override
  Future<void> setRhymes(HistoryRhymes rhymes) async {
    await rhymesBox.add(rhymes);
  }

  @override
  Future<void> clear() async {
    await rhymesBox.clear();
  }
}
