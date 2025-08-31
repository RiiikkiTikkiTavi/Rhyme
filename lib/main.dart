import 'package:flutter/material.dart';
import 'package:rhyme/router/router.dart';

void main() {
  runApp(const RhymeApp());
}

class RhymeApp extends StatefulWidget {
  const RhymeApp({super.key});

  @override
  State<RhymeApp> createState() => _RhymeAppState();
}

class _RhymeAppState extends State<RhymeApp> {
  final _router = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color.fromARGB(255, 253, 44, 17);
    return MaterialApp.router(
      title: 'Rhyme',
      theme: ThemeData(
        primaryColor: primaryColor,
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        scaffoldBackgroundColor: Colors.white70,
      ),
      routerConfig: _router.config(),
    );
  }
}
