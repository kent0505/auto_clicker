import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'clicker_event.dart';
part 'clicker_state.dart';

class ClickerBloc extends Bloc<ClickerEvent, Clicker> {
  ClickerBloc() : super(Clicker(100, 200)) {
    on<ClickerEvent>(
      (event, emit) => switch (event) {
        ChangeClickerPosition() => _onChangeClickerPisition(event, emit),
      },
    );
  }

  void _onChangeClickerPisition(
    ChangeClickerPosition event,
    Emitter<Clicker> emit,
  ) {
    emit(Clicker(event.x, event.y));
  }
}
