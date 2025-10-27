import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhyme/api/api.dart';
import 'package:rhyme/api/models/models.dart';

part 'rhymes_list_event.dart';
part 'rhymes_list_state.dart';

class RhymesListBloc extends Bloc<RhymesListEvent, RhymesListState> {
  RhymesListBloc({required this.apiClient}) : super(RhymesListInitial()) {
    on<SearchRhymes>(_onSearch);
  }

  Future<void> _onSearch(
    SearchRhymes event,
    Emitter<RhymesListState> emit,
  ) async {
    try {
      emit(RhymesListLoading());
      final rhymes = await apiClient.getRhymesList(event.query);
      emit(RhymesListLoaded(rhymes));
    } catch (e) {
      emit(RhymesListFailure(e));
    }
  }

  final RhymerApiClient apiClient;
}
