// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  final List<FavoriteRhymes> _favoriteRhymes;

  const RhymesListLoaded({
    required this.rhymes,
    required this.query,
    required List<FavoriteRhymes> favoriteRhymes,
  }) : _favoriteRhymes = favoriteRhymes;

  bool isFavorite(String rhyme) {
    return _favoriteRhymes
        .where((e) => e.favoriteWord == rhyme && e.queryWord == query)
        .isNotEmpty;
  }

  @override
  List<Object> get props =>
      super.props..addAll([rhymes, query, _favoriteRhymes]);

  RhymesListLoaded copyWith({
    Rhymes? rhymes,
    String? query,
    List<FavoriteRhymes>? favoriteRhymes,
  }) {
    return RhymesListLoaded(
      rhymes: rhymes ?? this.rhymes,
      query: query ?? this.query,
      favoriteRhymes: favoriteRhymes ?? _favoriteRhymes,
    );
  }
}

final class RhymesListFailure extends RhymesListState {
  final Object error;

  const RhymesListFailure(this.error);

  @override
  List<Object> get props => super.props..add(error);
}
