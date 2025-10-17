part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

final class GetTheme extends SettingsEvent {}

final class SetTheme extends SettingsEvent {
  SetTheme({required this.id});

  final int id;
}
