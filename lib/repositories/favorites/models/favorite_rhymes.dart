// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_ce/hive.dart';

part 'favorite_rhymes.g.dart';

@HiveType(typeId: 1)
class FavoriteRhymes extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String queryWord;
  @HiveField(2)
  final String favoriteWord;
  @HiveField(3)
  final List<String> words;
  @HiveField(4)
  final DateTime createdAt;
  FavoriteRhymes({
    required this.id,
    required this.queryWord,
    required this.favoriteWord,
    required this.words,
    required this.createdAt,
  });
}
