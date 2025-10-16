import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rhyme/ui/ui.dart';

@RoutePage()
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            snap: true,
            floating: true,
            title: Text('История'),
            elevation: 0,
            surfaceTintColor: Colors.transparent,
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio:
                    1.6, // соотношение длины к ширине одной карточки
              ),
              delegate: SliverChildBuilderDelegate((
                BuildContext context,
                int index,
              ) {
                return const RhymeHistoryCard(
                  rhymes: [
                    'xdcfgyhu',
                    'tedryugh',
                    'rtvy',
                    'tfhui',
                    'xcfvgbhj',
                    'rtvygbhn',
                    'tfyguhhui',
                    'ytgukhyhu',
                  ],
                );
              }, childCount: 20),
            ),
          ),
        ],
      ),
    );
  }
}
