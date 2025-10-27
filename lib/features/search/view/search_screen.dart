import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            child: SizedBox(
              height: 100,
              child: ListView.separated(
                padding: const EdgeInsets.only(left: 16),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final rhymes = List.generate(4, (index) => 'Рифма $index');
                  return RhymeHistoryCard(rhymes: rhymes);
                },
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          BlocBuilder<RhymesListBloc, RhymesListState>(
            builder: (context, state) {
              if (state is RhymesListLoaded) {
                final rhymes = state.rhymes.words;
                return SliverList.builder(
                  itemCount: rhymes.length,
                  itemBuilder: (context, index) =>
                      RhymeListCard(rhyme: rhymes[index]),
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
