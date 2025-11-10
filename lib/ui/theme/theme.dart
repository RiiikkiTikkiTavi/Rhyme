import 'package:flutter/material.dart';

final primaryColor = const Color.fromARGB(255, 253, 44, 17);

final darkTheme = ThemeData(
  useMaterial3: true,
  primaryColor: primaryColor,
  textTheme: textTheme,
  scaffoldBackgroundColor: Colors.black.withAlpha(200),
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.dark,
  ),
);

final lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: primaryColor,
  textTheme: textTheme,
  scaffoldBackgroundColor: Colors.white.withAlpha(200),
  dividerTheme: DividerThemeData(color: Colors.grey.withAlpha(90)),
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.light,
  ),
);

final textTheme = const TextTheme(
  titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
);
