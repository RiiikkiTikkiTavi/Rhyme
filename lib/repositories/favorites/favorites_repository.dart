import 'package:hive_ce/hive.dart';
import 'package:rhyme/repositories/favorites/favorites.dart';

class FavoritesRepository implements FavoritesRepositoryInterface {
  final Box<FavoriteRhymes> rhymesBox;

  FavoritesRepository({required this.rhymesBox});

  @override
  Future<void> createOrDeleteRhymes(FavoriteRhymes rhymes) async {
    final rhymesList = rhymesBox.values
        .where(
          (item) =>
              item.queryWord == rhymes.queryWord &&
              item.favoriteWord == rhymes.favoriteWord,
        )
        .toList();
    if (rhymesList.isNotEmpty) {
      for (var e in rhymesList) {
        await e.delete();
      }
    }
    await rhymesBox.add(rhymes);
  }

  @override
  Future<List<FavoriteRhymes>> getRhymesList() async {
    return rhymesBox.values.toList();
  }

  @override
  Future<void> clear() async {
    await rhymesBox.clear();
  }
}
