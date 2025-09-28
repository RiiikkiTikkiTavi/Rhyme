import 'package:flutter/material.dart';

final primaryColor = const Color.fromARGB(255, 253, 44, 17);

final themeData = ThemeData(
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
  scaffoldBackgroundColor: Colors.white70,
  useMaterial3: true,
  textTheme: const TextTheme(),
);
