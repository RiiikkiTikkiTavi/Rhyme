import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhyme/api/models/rhymes.dart';
import 'package:rhyme/features/history/history.dart';
import 'package:rhyme/features/search/bloc/rhymes_list_bloc.dart';
import 'package:rhyme/features/search/search.dart';
import 'package:rhyme/ui/ui.dart';

@RoutePage()
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<HistoryRhymesBloc>(context).add(LoadHistoryRhymes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true, // закрепить appbar наверху
            //snap: true, // только при floating: true, зафиксировать в поле зрения
            floating: true, // сделать видимой при прокручивании вверх
            backgroundColor: theme.cardColor,
            title: const Text("Rhyme"),
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: SearchButton(
                onTap: () => _showSearchBottomSheet(context),
                controller: _searchController,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ), // передать другой виджет в сливер
          SliverToBoxAdapter(
            child: BlocBuilder<HistoryRhymesBloc, HistoryRhymesState>(
              builder: (context, state) {
                if (state is! HistoryRhymesLoaded) return const SizedBox();
                return SizedBox(
                  height: 100,
                  child: ListView.separated(
                    padding: const EdgeInsets.only(left: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.rhymes.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      final rhymes = state.rhymes[index];
                      return RhymeHistoryCard(
                        rhymes: rhymes.words,
                        word: rhymes.word,
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          BlocConsumer<RhymesListBloc, RhymesListState>(
            listener: (context, state) {
              _handlRhymesListState(state, context);
            },
            builder: (context, state) {
              if (state is RhymesListLoaded) {
                final rhymesModel = state.rhymes;
                final rhymes = rhymesModel.words;
                return SliverList.builder(
                  itemCount: rhymes.length,
                  itemBuilder: (context, index) {
                    final currentRhyme = rhymes[index];
                    return RhymeListCard(
                      rhyme: currentRhyme,
                      isFavorite: state.isFavorite(currentRhyme),
                      onTap: () {
                        _toggleFavorite(
                          context,
                          rhymesModel,
                          state,
                          currentRhyme,
                        );
                      },
                    );
                  },
                );
              }
              if (state is RhymesListInitial) {
                return const SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'Начни искать рифмы',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }
              return const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ],
      ),
    );
  }

  void _toggleFavorite(
    BuildContext context,
    Rhymes rhymesModel,
    RhymesListLoaded state,
    String currentRhyme,
  ) {
    BlocProvider.of<RhymesListBloc>(context).add(
      ToggleFavoriteRhymes(
        rhymes: rhymesModel,
        query: state.query,
        favoriteWord: currentRhyme,
      ),
    );
  }

  void _handlRhymesListState(RhymesListState state, BuildContext context) {
    if (state is RhymesListLoaded) {
      BlocProvider.of<HistoryRhymesBloc>(context).add(LoadHistoryRhymes());
    }
  }

  Future<void> _showSearchBottomSheet(BuildContext context) async {
    final bloc = BlocProvider.of<RhymesListBloc>(context);
    final query = await showModalBottomSheet<String>(
      isScrollControlled: true, // логика скролла и размеры определяется ребенка
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) =>
          SearchRhymesBottomSheet(controller: _searchController),
    );
    if (query?.isNotEmpty ?? false) {
      bloc.add(SearchRhymes(query: query!));
    }
  }
}
