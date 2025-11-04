// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:rhyme/ui/ui.dart';

class RhymeHistoryCard extends StatelessWidget {
  const RhymeHistoryCard({super.key, required this.rhymes, required this.word});

  final List<String> rhymes;
  final String word;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseContainer(
      width: 200,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min, //колонка расширается по мере контента
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            word,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          Flexible(
            child: Text(
              rhymes.map((e) => e).join(', '),
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 13,
                color: theme.hintColor.withAlpha(60),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
