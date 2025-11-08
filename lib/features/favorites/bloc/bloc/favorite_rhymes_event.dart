part of 'favorite_rhymes_bloc.dart';

sealed class FavoriteRhymesEvent extends Equatable {
  const FavoriteRhymesEvent();

  @override
  List<Object> get props => [];
}

final class LoadFavoriteRhymes extends FavoriteRhymesEvent {}

class SearchRhymes extends FavoriteRhymesEvent {
  final String query;

  const SearchRhymes({required this.query});

  @override
  List<Object> get props => super.props..addAll([query]);
}
