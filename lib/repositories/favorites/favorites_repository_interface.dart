import 'package:rhyme/repositories/favorites/models/models.dart';

abstract interface class FavoritesRepositoryInterface {
  Future<List<FavoriteRhymes>> getRhymesList();
  Future<void> createOrDeleteRhymes(FavoriteRhymes rhymes);
  Future<void> clear();
}
