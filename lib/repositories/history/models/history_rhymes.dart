import 'package:hive_ce/hive.dart';

part 'history_rhymes.g.dart';

@HiveType(typeId: 0)
class HistoryRhymes extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  List<String> word;
  HistoryRhymes({required this.id, required this.word});
}
