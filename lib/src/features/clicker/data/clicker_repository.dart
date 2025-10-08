import 'package:shared_preferences/shared_preferences.dart';

abstract interface class ClickerRepository {
  const ClickerRepository();

  Future<void> removeClicker();
}

final class ClickerRepositoryImpl implements ClickerRepository {
  ClickerRepositoryImpl({required SharedPreferences prefs}) : _prefs = prefs;

  final SharedPreferences _prefs;

  @override
  Future<void> removeClicker() async {
    _prefs.hashCode;
  }
}
