// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'rhymes_list_bloc.dart';

sealed class RhymesListEvent extends Equatable {
  const RhymesListEvent();

  @override
  List<Object?> get props => [];
}

class SearchRhymes extends RhymesListEvent {
  final String query;
  const SearchRhymes({required this.query});

  @override
  List<Object?> get props => super.props..addAll([query]);
}

class ToggleFavoriteRhymes extends RhymesListEvent {
  final Rhymes rhymes;
  final String query;
  final String favoriteWord;
  final Completer? completer;

  const ToggleFavoriteRhymes({
    required this.rhymes,
    required this.query,
    required this.favoriteWord,
    this.completer,
  });

  @override
  List<Object?> get props =>
      super.props..addAll([rhymes, query, favoriteWord, completer]);
}
