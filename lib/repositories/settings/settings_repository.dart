// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:rhyme/repositories/settings/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository implements SettingsRepositoryInterface {
  final SharedPreferences preferences;
  SettingsRepository({required this.preferences});

  static const _isDartThemeSelectedKey = 'dark_theme_selected';

  @override
  bool isDarkThemeSelected() {
    final selected = preferences.getBool(_isDartThemeSelectedKey);
    return selected ?? false;
  }

  @override
  Future<void> setDarkThemeSelected(bool selected) async {
    await preferences.setBool(_isDartThemeSelectedKey, selected);
  }
}
