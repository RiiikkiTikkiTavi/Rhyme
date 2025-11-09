part of 'favorite_rhymes_bloc.dart';

sealed class FavoriteRhymesEvent extends Equatable {
  const FavoriteRhymesEvent();

  @override
  List<Object> get props => [];
}

final class LoadFavoriteRhymes extends FavoriteRhymesEvent {}
