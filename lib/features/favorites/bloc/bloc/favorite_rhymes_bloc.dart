import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhyme/repositories/favorites/favorites.dart';

part 'favorite_rhymes_event.dart';
part 'favorite_rhymes_state.dart';

class FavoriteRhymesBloc
    extends Bloc<FavoriteRhymesEvent, FavoriteRhymesState> {
  FavoriteRhymesBloc({
    required FavoritesRepositoryInterface favoritesRepository,
  }) : _favoriteRepository = favoritesRepository,
       super(FavoriteRhymesInitial()) {
    on<LoadFavoriteRhymes>(_load);
  }

  Future<void> _load(
    LoadFavoriteRhymes event,
    Emitter<FavoriteRhymesState> emit,
  ) async {
    try {
      emit(FavoriteRhymesLoading());
      final rhymes = await _favoriteRepository.getRhymesList();
      emit(FavoriteRhymesLoaded(rhymes: rhymes));
    } catch (e) {
      emit(FavoriteRhymesFailure(error: e));
    }
  }

  final FavoritesRepositoryInterface _favoriteRepository;
}
