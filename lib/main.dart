import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rhyme/api/api.dart';
import 'package:rhyme/router/router.dart';
import 'package:rhyme/ui/ui.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final client = RhymerApiClient.create(
    apiUrl: dotenv.env['API_URL'],
    apiKey: dotenv.env['API_KEY'],
  );
  runApp(const RhymeApp());
}

class RhymeApp extends StatefulWidget {
  const RhymeApp({super.key});

  @override
  State<RhymeApp> createState() => _RhymeAppState();
}

class _RhymeAppState extends State<RhymeApp> {
  final _router = AppRouter();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Rhyme',
      theme: themeData,
      routerConfig: _router.config(),
    );
  }
}
