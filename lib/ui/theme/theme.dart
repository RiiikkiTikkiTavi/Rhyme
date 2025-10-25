import 'package:flutter/material.dart';

final primaryColor = const Color.fromARGB(255, 253, 44, 17);

final themeData = ThemeData(
  dividerTheme: DividerThemeData(color: Colors.grey.withAlpha(90)),
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    surface: Colors.white,
  ),
  //scaffoldBackgroundColor: const Color.fromARGB(255, 30, 136, 241),
  useMaterial3: true,
  textTheme: const TextTheme(
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  ),
);
