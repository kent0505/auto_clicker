import 'package:auto_clicker/src/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _repository;

  SettingsBloc({required SettingsRepository repository})
      : _repository = repository,
        super(const SettingsState()) {
    on<SettingsEvent>(
      (event, emit) => switch (event) {
        GetTheme() => _getTheme(event, emit),
        SetTheme() => _setTheme(event, emit),
      },
    );
  }

  void _getTheme(
    GetTheme event,
    Emitter<SettingsState> emit,
  ) {
    final id = _repository.getTheme();
    logger(id);
    emit(
      state.copyWith(
        themeMode: switch (id) {
          1 => ThemeMode.light,
          2 => ThemeMode.dark,
          _ => ThemeMode.system,
        },
      ),
    );
  }

  void _setTheme(
    SetTheme event,
    Emitter<SettingsState> emit,
  ) async {
    await _repository.setTheme(event.id);
    add(GetTheme());
  }
}
