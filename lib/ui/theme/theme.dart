import 'package:flutter/material.dart';

final _primaryColor = const Color.fromARGB(255, 253, 44, 17);

final darkTheme = ThemeData(
  useMaterial3: true,
  primaryColor: _primaryColor,
  textTheme: _textTheme,
  scaffoldBackgroundColor: Colors.black.withAlpha(200),
  colorScheme: ColorScheme.fromSeed(
    seedColor: _primaryColor,
    brightness: Brightness.dark,
  ),
);

final lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: _primaryColor,
  textTheme: _textTheme,
  scaffoldBackgroundColor: Colors.white.withAlpha(200),
  dividerTheme: DividerThemeData(color: Colors.grey.withAlpha(90)),
  colorScheme: ColorScheme.fromSeed(
    seedColor: _primaryColor,
    brightness: Brightness.light,
  ),
);

final _textTheme = const TextTheme(
  titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
);
