import 'package:json_annotation/json_annotation.dart';
import 'package:rhyme/repositories/history/history.dart';
import 'package:uuid/uuid.dart';

part 'rhymes.g.dart';

@JsonSerializable()
class Rhymes {
  const Rhymes({required this.words});

  factory Rhymes.fromJson(Map<String, dynamic> json) => _$RhymesFromJson(json);

  final List<String> words;

  Map<String, dynamic> toJson() => _$RhymesToJson(this);

  HistoryRhymes toHistory(String word) =>
      HistoryRhymes(id: const Uuid().v4().toString(), word: word, words: words);
}
