import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants.dart';

abstract interface class SettingsRepository {
  const SettingsRepository();

  int getTheme();

  Future<void> setTheme(final int id);
}

final class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl({required SharedPreferences prefs}) : _prefs = prefs;

  final SharedPreferences _prefs;

  @override
  int getTheme() {
    return _prefs.getInt(Keys.themeID) ?? 2; // by default dark
  }

  @override
  Future<void> setTheme(final int id) async {
    await _prefs.setInt(Keys.themeID, id);
  }
}
