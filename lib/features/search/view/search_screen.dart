import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rhyme/features/search/search.dart';
import 'package:rhyme/ui/ui.dart';

@RoutePage()
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true, // закрепить appbar наверху
          //snap: true, // только при floating: true, зафиксировать в поле зрения
          floating: true, // сделать видимой при прокручивании вверх
          title: const Text("Rhyme"),
          //backgroundColor: theme.primaryColor,
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
          itemBuilder: (context, index) => const RhymeListCard(rhyme: 'Рифма'),
        ),
      ],
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

class SearchRhymesBottomSheet extends StatelessWidget {
  const SearchRhymesBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseBottomSheet(
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: theme.hintColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Начни вводить слово...',
                  hintStyle: TextStyle(color: theme.hintColor.withAlpha(70)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class BaseBottomSheet extends StatelessWidget {
  const BaseBottomSheet({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [SizedBox(width: double.infinity, child: child)],
        ),
      ),
    );
  }
}
