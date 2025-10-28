import 'package:apphud/models/apphud_models/apphud_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/icon_widget.dart';
import '../../../core/widgets/main_button.dart';
import '../bloc/vip_bloc.dart';
import '../widgets/vip_tile.dart';

class VipScreen extends StatefulWidget {
  const VipScreen({super.key});

  static const routePath = '/VipScreen';

  @override
  State<VipScreen> createState() => _VipScreenState();
}

class _VipScreenState extends State<VipScreen> {
  ApphudProduct? selectedProduct;

  void onGetStarted() {
    context.read<VipBloc>().add(PurchaseVip(product: selectedProduct!));
  }

  void onSelect(ApphudProduct value) {
    setState(() {
      selectedProduct = value == selectedProduct ? null : value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(Constants.padding),
        child: BlocConsumer<VipBloc, VipState>(
          // listenWhen: (previous, current) {
          //   return previous.loading != current.loading;
          // },
          listener: (context, state) {},
          builder: (context, state) {
            return Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: Constants.padding +
                          MediaQuery.of(context).viewPadding.top,
                    ),
                    Image.asset(
                      Assets.icon,
                      height: 100,
                      color: colors.text,
                      frameBuilder: frameBuilder,
                    ),
                    const SizedBox(height: Constants.padding),
                    Text(
                      'Get VIP for Full Access',
                      style: TextStyle(
                        color: colors.text,
                        fontSize: 24,
                        fontFamily: AppFonts.w600,
                      ),
                    ),
                    const Spacer(),
                    ...List.generate(
                      state.products.length,
                      (index) {
                        return VipTile(
                          product: state.products[index],
                          current: selectedProduct,
                          loading: state.loading,
                          onPressed: onSelect,
                        );
                      },
                    ),
                    MainButton(
                      title: 'Get started',
                      loading: state.loading,
                      // active: selectedPackage != null,
                      onPressed: onGetStarted,
                    ),
                  ],
                ),
                if (!state.loading)
                  Positioned(
                    top: MediaQuery.of(context).viewPadding.top,
                    right: 0,
                    child: Button(
                      onPressed: () {
                        context.pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: colors.tile,
                          shape: BoxShape.circle,
                        ),
                        child: const IconWidget(MyIcons.close),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
