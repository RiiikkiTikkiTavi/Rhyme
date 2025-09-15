import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 8),
      decoration: BoxDecoration(
        //color: theme.hintColor.withValues(alpha: 10),
        color: theme.hintColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.search_rounded),
          const SizedBox(width: 12),
          Text(
            "поиск рифм...",
            style: TextStyle(
              fontSize: 18,
              color: theme.hintColor.withValues(alpha: 0.4),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
