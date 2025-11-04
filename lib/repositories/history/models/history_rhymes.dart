// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_ce/hive.dart';

part 'history_rhymes.g.dart';

@HiveType(typeId: 0)
class HistoryRhymes extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  List<String> words;
  @HiveField(2)
  String word;
  HistoryRhymes({required this.id, required this.word, required this.words});

  @override
  String toString() => 'HistoryRhymes(id: $id, word: $word, words: $words)';
}
