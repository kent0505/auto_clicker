import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/click.dart';
import '../models/swipe.dart';

part 'clicker_event.dart';
part 'clicker_state.dart';

class ClickerBloc extends Bloc<ClickerEvent, ClickerState> {
  final _random = Random();

  ClickerBloc() : super(ClickerState(clicks: [Click()])) {
    on<ClickerEvent>(
      (event, emit) => switch (event) {
        ChangeInterval() => _onChangeInterval(event, emit),
        ChangeRepeat() => _onChangeRepeat(event, emit),
        ChangeDoubleClick() => _onChangeDoubleClick(event, emit),
        ChangeSwipeMode() => _onChangeSwipeMode(event, emit),
        ResetClicks() => _onResetClicks(event, emit),
        AddClick() => _onAddClick(event, emit),
        RemoveClick() => _onRemoveClick(event, emit),
        MoveClick() => _onMoveClick(event, emit),
      },
    );
  }

  void _onChangeInterval(
    ChangeInterval event,
    Emitter<ClickerState> emit,
  ) {
    emit(state.copyWith(interval: event.interval));
  }

  void _onChangeRepeat(
    ChangeRepeat event,
    Emitter<ClickerState> emit,
  ) {
    emit(state.copyWith(repeat: event.repeat));
  }

  void _onChangeDoubleClick(
    ChangeDoubleClick event,
    Emitter<ClickerState> emit,
  ) {
    emit(state.copyWith(doubleClick: !state.doubleClick));
  }

  void _onChangeSwipeMode(
    ChangeSwipeMode event,
    Emitter<ClickerState> emit,
  ) {
    emit(state.copyWith(swipeMode: !state.swipeMode));
  }

  void _onResetClicks(
    ResetClicks event,
    Emitter<ClickerState> emit,
  ) {
    emit(
      state.copyWith(
        clicks: state.clicks.map((_) {
          return Click(
            x: 100 * _random.nextDouble() * 2,
            y: 100 * _random.nextDouble() * 2,
          );
        }).toList(),
      ),
    );
  }

  void _onAddClick(
    AddClick event,
    Emitter<ClickerState> emit,
  ) {
    final clicks = List<Click>.from(state.clicks);
    clicks.add(
      Click(
        x: 100 * _random.nextDouble() * 2,
        y: 100 * _random.nextDouble() * 2,
      ),
    );
    emit(state.copyWith(clicks: clicks));
  }

  void _onRemoveClick(
    RemoveClick event,
    Emitter<ClickerState> emit,
  ) {
    final clicks = List<Click>.from(state.clicks);
    clicks.remove(event.click);
    emit(state.copyWith(clicks: clicks));
  }

  void _onMoveClick(
    MoveClick event,
    Emitter<ClickerState> emit,
  ) {
    final clicks = List<Click>.from(state.clicks);

    emit(state.copyWith(clicks: clicks));
  }
}
