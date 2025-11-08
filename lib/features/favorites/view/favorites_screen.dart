import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rhyme/ui/ui.dart';

@RoutePage()
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            snap: true,
            floating: true,
            title: Text('Избранное'),
            elevation: 0,
            surfaceTintColor: Colors.transparent,
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverList.builder(
            itemBuilder: (context, index) => RhymeListCard(
              isFavorite: true,
              rhyme: 'Рифма',
              sourceWord: 'Слово',
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
