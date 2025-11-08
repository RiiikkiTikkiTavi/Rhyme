part of 'favorite_rhymes_bloc.dart';

sealed class FavoriteRhymesState extends Equatable {
  const FavoriteRhymesState();

  @override
  List<Object> get props => [];
}

final class FavoriteRhymesInitial extends FavoriteRhymesState {}

final class FavoriteRhymesLoading extends FavoriteRhymesState {}

final class FavoriteRhymesLoaded extends FavoriteRhymesState {
  final List<FavoriteRhymes> rhymes;

  const FavoriteRhymesLoaded({required this.rhymes});

  @override
  List<Object> get props => super.props..addAll(rhymes);
}

final class FavoriteRhymesFailure extends FavoriteRhymesState {
  final Object error;

  const FavoriteRhymesFailure({required this.error});

  @override
  List<Object> get props => super.props..add(error);
}
