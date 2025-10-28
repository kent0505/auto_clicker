import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:apphud/apphud.dart';
import 'package:apphud/models/apphud_models/apphud_product.dart';

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
      final isVip = await Apphud.hasActiveSubscription();

      final placements = await Apphud.placements();

      final paywall = placements.first.paywall;
      final products = paywall?.products ?? [];

      for (final product in products) {
        logger(product.productDetails?.title ?? 'null title');
        logger(product.productDetails?.description ?? 'null description');
        logger(product.skProduct?.price ?? 'null price');
      }

      emit(state.copyWith(
        isVip: isVip,
        loading: false,
        products: products,
      ));
    } catch (e) {
      logger(e);
      emit(state.copyWith(
        isVip: false,
        loading: false,
      ));
    }
  }

  void _purchaseVip(
    PurchaseVip event,
    Emitter<VipState> emit,
  ) async {
    emit(state.copyWith(loading: true));

    try {
      await Apphud.purchase(product: event.product);

      // add(CheckVip());
    } catch (e) {
      logger(e);
      emit(state.copyWith(
        isVip: false,
        loading: false,
      ));
    }
  }
}
