import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:rhyme/repositories/favorites/favorites.dart';
import 'package:rhyme/repositories/history/history.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfig {
  final Box<HistoryRhymes> historyBox;
  final Box<FavoriteRhymes> favoriteBox;
  final SharedPreferences preferences;

  AppConfig(this.historyBox, this.favoriteBox, this.preferences);
}
