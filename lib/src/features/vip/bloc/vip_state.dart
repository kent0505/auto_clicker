part of 'vip_bloc.dart';

class VipState {
  VipState({
    this.isVip = false,
    this.loading = false,
    this.init = true,
    this.products = const [],
  });

  final bool isVip;
  final bool loading;
  final bool init;
  final List<ApphudProduct> products;

  VipState copyWith({
    bool? isVip,
    bool? loading,
    bool? init,
    List<ApphudProduct>? products,
  }) {
    return VipState(
      isVip: isVip ?? this.isVip,
      loading: loading ?? this.loading,
      init: init ?? this.init,
      products: products ?? this.products,
    );
  }
}
