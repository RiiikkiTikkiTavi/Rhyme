// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'rhymes_list_bloc.dart';

sealed class RhymesListEvent extends Equatable {
  const RhymesListEvent();

  @override
  List<Object> get props => [];
}

class SearchRhymes extends RhymesListEvent {
  final String query;
  const SearchRhymes({required this.query});

  @override
  List<Object> get props => super.props..addAll([query]);
}
