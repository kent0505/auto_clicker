import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';

part 'vip_event.dart';
part 'vip_state.dart';

class VipBloc extends Bloc<VipEvent, VipState> {
  VipBloc() : super(VipState()) {
    on<VipEvent>(
      (event, emit) => switch (event) {
        CheckVip() => _checkVip(event, emit),
      },
    );
  }

  void _checkVip(
    CheckVip event,
    Emitter<VipState> emit,
  ) async {
    emit(state.copyWith(loading: true));

    try {
      Offerings offerings = await Purchases.getOfferings().timeout(
        const Duration(seconds: 3),
      );
      final offering = offerings.getOffering(Identifiers.paywall1);
      logger(offering?.identifier.isNotEmpty ?? '');

      emit(state.copyWith(
        title: offering?.identifier ?? '',
        loading: false,
        isVIP: offering?.identifier.isNotEmpty ?? false,
        offering: offering,
      ));
    } catch (e) {
      emit(state.copyWith(loading: false));
    }
  }
}
