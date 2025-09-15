import 'package:flutter/material.dart';

class BaseContainer extends StatelessWidget {
  const BaseContainer({
    super.key,
    required this.child,
    required this.width,
    this.margin,
    this.padding = const EdgeInsets.only(left: 12),
  });
  final Widget child;
  final double width;
  final EdgeInsets? margin;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: width, // double.infinity,
      height: 40,
      margin: margin,
      padding: padding, //EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
