part of 'vip_bloc.dart';

class VipState {
  VipState({
    this.isVIP = false,
    this.loading = false,
    this.offering,
    this.title = '',
  });

  final bool isVIP;
  final bool loading;
  final Offering? offering;
  final String title;

  VipState copyWith({
    bool? isVIP,
    bool? loading,
    Offering? offering,
    String? title,
  }) {
    return VipState(
      isVIP: isVIP ?? this.isVIP,
      loading: loading ?? this.loading,
      offering: offering ?? this.offering,
      title: title ?? this.title,
    );
  }
}
