import 'package:flutter/material.dart';

final primaryColor = const Color.fromARGB(255, 253, 44, 17);

final themeData = ThemeData(
  dividerTheme: DividerThemeData(color: Colors.grey.withAlpha(90)),
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
  scaffoldBackgroundColor: Colors.white.withAlpha(200),
  useMaterial3: true,
  textTheme: const TextTheme(
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  ),
);
