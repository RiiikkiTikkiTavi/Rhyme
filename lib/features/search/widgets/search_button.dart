import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    super.key,
    required this.onTap,
    required this.controller,
  });

  final VoidCallback onTap;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context, _) {
                return Text(
                  controller.text.isEmpty ? 'поиск рифм...' : controller.text,
                  style: TextStyle(
                    fontSize: 18,
                    color: theme.hintColor.withValues(alpha: 0.4),
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
