part of 'rhymes_list_bloc.dart';

sealed class RhymesListState extends Equatable {
  const RhymesListState();

  @override
  List<Object> get props => [];
}

final class RhymesListInitial extends RhymesListState {}

final class RhymesListLoading extends RhymesListState {}

final class RhymesListLoaded extends RhymesListState {
  final Rhymes rhymes;
  final String query;

  const RhymesListLoaded({required this.rhymes, required this.query});
  @override
  List<Object> get props => super.props..addAll([rhymes, query]);
}

final class RhymesListFailure extends RhymesListState {
  final Object error;

  const RhymesListFailure(this.error);

  @override
  List<Object> get props => super.props..add(error);
}
