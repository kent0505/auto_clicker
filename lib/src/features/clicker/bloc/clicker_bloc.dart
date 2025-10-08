import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/clicker_repository.dart';

part 'clicker_event.dart';
part 'clicker_state.dart';

class ClickerBloc extends Bloc<ClickerEvent, ClickerState> {
  // ignore: unused_field
  final ClickerRepository _repository;

  ClickerBloc(ClickerRepository repository)
      : _repository = repository,
        super(ClickerInitial()) {
    on<ClickerEvent>(
      (event, emit) => switch (event) {},
    );
  }
}
