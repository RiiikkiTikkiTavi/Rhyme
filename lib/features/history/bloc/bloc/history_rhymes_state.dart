part of 'history_rhymes_bloc.dart';

sealed class HistoryRhymesState extends Equatable {
  const HistoryRhymesState();

  @override
  List<Object> get props => [];
}

final class HistoryRhymesInitial extends HistoryRhymesState {}

final class HistoryRhymesLoading extends HistoryRhymesState {}

final class HistoryRhymesLoaded extends HistoryRhymesState {
  final List<HistoryRhymes> rhymes;

  const HistoryRhymesLoaded(this.rhymes);

  @override
  List<Object> get props => super.props..add(rhymes);
}

final class HistoryRhymesFailure extends HistoryRhymesState {
  final Object error;

  const HistoryRhymesFailure(this.error);

  @override
  List<Object> get props => super.props..add(error);
}
