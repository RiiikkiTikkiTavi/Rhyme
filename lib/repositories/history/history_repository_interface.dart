import 'package:rhyme/repositories/history/models/models.dart';

abstract interface class HistoryRepositoryInterface {
  Future<List<HistoryRhymes>> getRhymesList();
  Future<void> setRhymes(HistoryRhymes rhymes);
  Future<void> clear();
}
