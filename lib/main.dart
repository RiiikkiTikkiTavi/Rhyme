// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:rhyme/api/api.dart';
import 'package:rhyme/bloc/theme/theme_cubit.dart';
import 'package:rhyme/features/favorites/bloc/bloc/favorite_rhymes_bloc.dart';
import 'package:rhyme/features/history/bloc/bloc/history_rhymes_bloc.dart';
import 'package:rhyme/features/search/bloc/rhymes_list_bloc.dart';
import 'package:rhyme/firebase_options.dart';
import 'package:rhyme/repositories/favorites/favorites.dart';
import 'package:rhyme/repositories/history/history.dart';
import 'package:rhyme/repositories/settings/settings.dart';
import 'package:rhyme/router/router.dart';
import 'package:rhyme/ui/ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final prefs = await SharedPreferences.getInstance();
  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  log('Firebase initialized: ${app.name}');
  final messaging = FirebaseMessaging.instance;
  await messaging.requestPermission();
  messaging.getToken().then((token) => log(token ?? 'Нет токена'));

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(channel);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    final notification = message.notification;
    final android = message.notification?.android;

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: 'ic_launcher',
          ),
        ),
      );
    }
  });
  runApp(
    RhymeApp(
      historyBox: historyBox,
      favoriteBox: favoriteBox,
      preferences: prefs,
    ),
  );
}

class RhymeApp extends StatefulWidget {
  const RhymeApp({
    super.key,
    required this.historyBox,
    required this.favoriteBox,
    required this.preferences,
  });

  final Box<HistoryRhymes> historyBox;
  final Box<FavoriteRhymes> favoriteBox;
  final SharedPreferences preferences;

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
    final settingsRepository = SettingsRepository(
      preferences: widget.preferences,
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
        BlocProvider(
          create: (context) =>
              ThemeCubit(settingsRepository: settingsRepository),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Rhyme',
            theme: state.isDark ? darkTheme : lightTheme,
            routerConfig: _router.config(),
          );
        },
      ),
    );
  }
}
