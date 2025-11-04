part of 'history_rhymes_bloc.dart';

sealed class HistoryRhymeEvent extends Equatable {
  const HistoryRhymeEvent();

  @override
  List<Object> get props => [];
}

final class LoadHistoryRhymes extends HistoryRhymeEvent {}

final class ClearRhymesHistory extends HistoryRhymeEvent {}
