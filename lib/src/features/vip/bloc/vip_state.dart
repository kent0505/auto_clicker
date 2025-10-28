part of 'vip_bloc.dart';

class VipState {
  VipState({
    this.isVIP = false,
    this.loading = false,
    this.init = true,
  });

  final bool isVIP;
  final bool loading;
  final bool init;

  VipState copyWith({
    bool? isVIP,
    bool? loading,
    bool? init,
  }) {
    return VipState(
      isVIP: isVIP ?? this.isVIP,
      loading: loading ?? this.loading,
      init: init ?? this.init,
    );
  }
}
