import 'package:flutter/material.dart';
import 'package:rhyme/ui/ui.dart';

class RhymeHistoryCard extends StatelessWidget {
  const RhymeHistoryCard({super.key, required this.rhymes});

  final List<String> rhymes;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseContainer(
      width: 200,
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min, //колонка расширается по мере контента
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Слово",
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          Flexible(
            child: Text(
              rhymes.map((e) => e).join(', '),
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
            ),
          ),
          // Wrap(
          //   children: rhymes
          //       .map(
          //         (e) => Padding(
          //           padding: const EdgeInsets.only(right: 4),
          //           child: Text(e),
          //         ),
          //       )
          //       .toList(),
          // ),
        ],
      ),
    );
  }
}
