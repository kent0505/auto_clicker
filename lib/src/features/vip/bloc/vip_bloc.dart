import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../core/utils.dart';

part 'vip_event.dart';
part 'vip_state.dart';

class VipBloc extends Bloc<VipEvent, VipState> {
  VipBloc() : super(VipState()) {
    on<VipEvent>(
      (event, emit) => switch (event) {
        CheckVip() => _checkVip(event, emit),
        PurchaseVip() => _purchaseVip(event, emit),
      },
    );
  }

  void _checkVip(
    CheckVip event,
    Emitter<VipState> emit,
  ) async {
    emit(state.copyWith(loading: true));

    try {
      final customerInfo = await Purchases.getCustomerInfo().timeout(
        const Duration(seconds: 3),
      );

      final offerings = await Purchases.getOfferings().timeout(
        const Duration(seconds: 3),
      );

      final offering = offerings.getOffering('paywall_1');

      emit(state.copyWith(
        isVIP: customerInfo.entitlements.active.isNotEmpty,
        loading: false,
        offering: offering,
      ));
    } catch (e) {
      logger(e);
      emit(state.copyWith(
        isVIP: false,
        loading: false,
        error: 'Something went wrong, try again later',
      ));
    }
  }

  void _purchaseVip(
    PurchaseVip event,
    Emitter<VipState> emit,
  ) async {
    emit(state.copyWith(loading: true));

    try {
      await Future.delayed(const Duration(seconds: 2));
      // заглушка покупки
      emit(state.copyWith(
        isVIP: true,
        loading: false,
        error: '',
      ));

      // await Purchases.purchasePackage(event.package);

      // add(CheckVip());
    } catch (e) {
      logger(e);
      emit(state.copyWith(
        isVIP: false,
        loading: false,
        error: 'Something went wrong, try again later',
      ));
    }
  }
}
