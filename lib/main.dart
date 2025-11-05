import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:rhyme/api/api.dart';
import 'package:rhyme/features/history/bloc/bloc/history_rhymes_bloc.dart';
import 'package:rhyme/features/search/bloc/rhymes_list_bloc.dart';
import 'package:rhyme/repositories/favorites/favorites.dart';
import 'package:rhyme/repositories/history/history.dart';
import 'package:rhyme/router/router.dart';
import 'package:rhyme/ui/ui.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Hive.initFlutter(); // инициализация
  Hive.registerAdapter(HistoryRhymesAdapter());
  String historyRhymesBoxName = 'history_rhymes';
  String favoriteRhymesBoxName = 'favorite_rhymes';
  final historyBox = await Hive.openBox<HistoryRhymes>(historyRhymesBoxName);
  final favoriteBox = await Hive.openBox<FavoriteRhymes>(favoriteRhymesBoxName);
  runApp(RhymeApp(historyBox: historyBox));
}

class RhymeApp extends StatefulWidget {
  const RhymeApp({super.key, required this.historyBox});

  final Box<HistoryRhymes> historyBox;

  @override
  State<RhymeApp> createState() => _RhymeAppState();
}

class _RhymeAppState extends State<RhymeApp> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    final historyRepository = HistoryRepository(rhymesBox: widget.historyBox);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RhymesListBloc(
            apiClient: RhymerApiClient.create(
              apiUrl: dotenv.env['API_URL'],
              apiKey: dotenv.env['API_KEY'],
            ),
            historyRepository: historyRepository,
          ),
        ),
        BlocProvider(
          create: (context) =>
              HistoryRhymesBloc(historyRepository: historyRepository),
        ),
      ],
      child: MaterialApp.router(
        title: 'Rhyme',
        theme: themeData,
        routerConfig: _router.config(),
      ),
    );
  }
}
