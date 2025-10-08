import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';

part 'vip_event.dart';

class VipBloc extends Bloc<VipEvent, bool> {
  VipBloc() : super(false) {
    on<VipEvent>(
      (event, emit) => switch (event) {
        CheckVip() => _checkVip(event, emit),
      },
    );
  }

  void _checkVip(
    CheckVip event,
    Emitter<bool> emit,
  ) async {
    Offerings offerings = await Purchases.getOfferings().timeout(
      const Duration(seconds: 3),
    );
    final offering = offerings.getOffering(Identifiers.paywall1);
    logger(offering?.identifier.isNotEmpty ?? '');
  }
}
