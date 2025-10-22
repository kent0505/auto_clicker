part of 'vip_bloc.dart';

class VipState {
  VipState({
    this.isVIP = false,
    this.loading = false,
    this.offering,
    this.error = '',
  });

  final bool isVIP;
  final bool loading;
  final Offering? offering;
  final String error;

  VipState copyWith({
    bool? isVIP,
    bool? loading,
    Offering? offering,
    String? error,
  }) {
    return VipState(
      isVIP: isVIP ?? this.isVIP,
      loading: loading ?? this.loading,
      offering: offering ?? this.offering,
      error: error ?? this.error,
    );
  }
}
