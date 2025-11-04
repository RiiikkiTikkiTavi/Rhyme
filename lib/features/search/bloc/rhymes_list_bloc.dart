import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhyme/api/api.dart';
import 'package:rhyme/api/models/models.dart';
import 'package:rhyme/repositories/history/history.dart';

part 'rhymes_list_event.dart';
part 'rhymes_list_state.dart';

class RhymesListBloc extends Bloc<RhymesListEvent, RhymesListState> {
  RhymesListBloc({
    required HistoryRepositoryInterface historyRepository,
    required RhymerApiClient apiClient,
  }) : _historyRepository = historyRepository,
       _apiClient = apiClient,
       super(RhymesListInitial()) {
    on<SearchRhymes>(_onSearch);
  }

  Future<void> _onSearch(
    SearchRhymes event,
    Emitter<RhymesListState> emit,
  ) async {
    try {
      emit(RhymesListLoading());
      final rhymes = await _apiClient.getRhymesList(event.query);
      final historyRhymes = rhymes.toHistory(event.query);
      _historyRepository.setRhymes(historyRhymes);
      emit(RhymesListLoaded(rhymes));
    } catch (e) {
      emit(RhymesListFailure(e));
    }
  }

  final RhymerApiClient _apiClient;
  final HistoryRepositoryInterface _historyRepository;
}
