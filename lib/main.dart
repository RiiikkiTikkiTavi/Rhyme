// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:rhyme/api/api.dart';
import 'package:rhyme/features/favorites/bloc/bloc/favorite_rhymes_bloc.dart';
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
  Hive.registerAdapter(FavoriteRhymesAdapter());
  String historyRhymesBoxName = 'history_rhymes';
  String favoriteRhymesBoxName = 'favorite_rhymes';
  //await Hive.deleteBoxFromDisk('history_rhymes');
  final historyBox = await Hive.openBox<HistoryRhymes>(historyRhymesBoxName);
  final favoriteBox = await Hive.openBox<FavoriteRhymes>(favoriteRhymesBoxName);
  runApp(RhymeApp(historyBox: historyBox, favoriteBox: favoriteBox));
}

class RhymeApp extends StatefulWidget {
  const RhymeApp({
    super.key,
    required this.historyBox,
    required this.favoriteBox,
  });

  final Box<HistoryRhymes> historyBox;
  final Box<FavoriteRhymes> favoriteBox;

  @override
  State<RhymeApp> createState() => _RhymeAppState();
}

class _RhymeAppState extends State<RhymeApp> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    final historyRepository = HistoryRepository(rhymesBox: widget.historyBox);
    final favoriteRepository = FavoritesRepository(
      rhymesBox: widget.favoriteBox,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RhymesListBloc(
            apiClient: RhymerApiClient.create(
              apiUrl: dotenv.env['API_URL'],
              apiKey: dotenv.env['API_KEY'],
            ),
            historyRepository: historyRepository,
            favoriteRepository: favoriteRepository,
          ),
        ),
        BlocProvider(
          create: (context) =>
              HistoryRhymesBloc(historyRepository: historyRepository),
        ),
        BlocProvider(
          create: (context) =>
              FavoriteRhymesBloc(favoritesRepository: favoriteRepository),
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
