import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, int> {
  HomeBloc() : super(0) {
    on<ChangePage>(_onChangePage);
  }

  void _onChangePage(
    ChangePage event,
    Emitter<int> emit,
  ) {
    emit(event.index);
  }
}
