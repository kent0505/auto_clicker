part of 'settings_bloc.dart';

final class SettingsState {
  const SettingsState({this.themeMode = ThemeMode.dark});

  final ThemeMode themeMode;

  SettingsState copyWith({
    ThemeMode? themeMode,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
