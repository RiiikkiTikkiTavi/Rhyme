// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rhyme/api/api.dart';
import 'package:rhyme/app/app.dart';
import 'package:rhyme/bloc/theme/theme_cubit.dart';
import 'package:rhyme/features/favorites/bloc/bloc/favorite_rhymes_bloc.dart';
import 'package:rhyme/features/history/bloc/bloc/history_rhymes_bloc.dart';
import 'package:rhyme/features/search/bloc/rhymes_list_bloc.dart';
import 'package:rhyme/repositories/favorites/favorites.dart';
import 'package:rhyme/repositories/history/history.dart';
import 'package:rhyme/repositories/settings/settings.dart';

class AppInitializer extends StatelessWidget {
  const AppInitializer({super.key, required this.child, required this.config});

  final AppConfig config;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<HistoryRepositoryInterface>(
          create: (context) => HistoryRepository(rhymesBox: config.historyBox),
        ),
        RepositoryProvider<FavoritesRepositoryInterface>(
          create: (context) =>
              FavoritesRepository(rhymesBox: config.favoriteBox),
        ),
        RepositoryProvider<SettingsRepositoryInterface>(
          create: (context) =>
              SettingsRepository(preferences: config.preferences),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => RhymesListBloc(
              apiClient: RhymerApiClient.create(
                apiUrl: dotenv.env['API_URL'],
                apiKey: dotenv.env['API_KEY'],
              ),
              historyRepository: context.read<HistoryRepositoryInterface>(),
              favoriteRepository: context.read<FavoritesRepositoryInterface>(),
            ),
          ),
          BlocProvider(
            create: (context) => HistoryRhymesBloc(
              historyRepository: context.read<HistoryRepositoryInterface>(),
            ),
          ),
          BlocProvider(
            create: (context) => FavoriteRhymesBloc(
              favoritesRepository: context.read<FavoritesRepositoryInterface>(),
            ),
          ),
          BlocProvider(
            create: (context) => ThemeCubit(
              settingsRepository: context.read<SettingsRepositoryInterface>(),
            ),
          ),
        ],
        child: child,
      ),
    );
  }
}
