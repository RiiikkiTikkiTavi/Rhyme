// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:rhyme/app/app.dart';
import 'package:rhyme/firebase_options.dart';
import 'package:rhyme/repositories/favorites/favorites.dart';
import 'package:rhyme/repositories/history/history.dart';
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

  final prefs = await _initPrefs();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final messaging = FirebaseMessaging.instance;
  await messaging.requestPermission();
  messaging.getToken().then((token) => log(token ?? 'Нет токена'));

  await _initNotification();

  final config = AppConfig(historyBox, favoriteBox, prefs);
  runApp(RhymeApp(config: config));
}

Future<void> _initNotification() async {
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
}

Future<SharedPreferences> _initPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs;
}
