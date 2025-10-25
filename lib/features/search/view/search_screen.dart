import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rhyme/features/search/search.dart';
import 'package:rhyme/ui/ui.dart';

@RoutePage()
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

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
              child: SearchButton(onTap: () => _showSearchBottomSheet(context)),
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
          SliverList.builder(
            itemBuilder: (context, index) =>
                const RhymeListCard(rhyme: 'Рифма'),
          ),
        ],
      ),
    );
  }

  void _showSearchBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true, // логика скролла и размеры определяется ребенка
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => const SearchRhymesBottomSheet(),
    );
  }
}
