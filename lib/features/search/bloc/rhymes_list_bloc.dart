import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhyme/api/api.dart';
import 'package:rhyme/api/models/models.dart';
import 'package:rhyme/repositories/favorites/favorites.dart';
import 'package:rhyme/repositories/history/history.dart';

part 'rhymes_list_event.dart';
part 'rhymes_list_state.dart';

class RhymesListBloc extends Bloc<RhymesListEvent, RhymesListState> {
  RhymesListBloc({
    required HistoryRepositoryInterface historyRepository,
    required FavoritesRepositoryInterface favoriteRepository,
    required RhymerApiClient apiClient,
  }) : _historyRepository = historyRepository,
       _favoriteRepository = favoriteRepository,
       _apiClient = apiClient,
       super(RhymesListInitial()) {
    on<SearchRhymes>(_onSearch);
    on<ToggleFavoriteRhymes>(_onToggleFavorite);
  }

  Future<void> _onSearch(
    SearchRhymes event,
    Emitter<RhymesListState> emit,
  ) async {
    try {
      emit(RhymesListLoading());
      final rhymes = await _apiClient.getRhymesList(event.query);
      final historyRhymes = rhymes.toHistory(event.query);
      await _historyRepository.setRhymes(historyRhymes);
      final favoriteRhymes = await _favoriteRepository.getRhymesList();
      emit(
        RhymesListLoaded(
          rhymes: rhymes,
          query: event.query,
          favoriteRhymes: favoriteRhymes,
        ),
      );
    } catch (e) {
      emit(RhymesListFailure(e));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteRhymes event,
    Emitter<RhymesListState> emit,
  ) async {
    try {
      await _favoriteRepository.createOrDeleteRhymes(
        event.rhymes.toFavorite(event.query, event.favoriteWord),
      );
    } catch (e) {
      emit(RhymesListFailure(e));
    }
  }

  final RhymerApiClient _apiClient;
  final HistoryRepositoryInterface _historyRepository;
  final FavoritesRepositoryInterface _favoriteRepository;
}
