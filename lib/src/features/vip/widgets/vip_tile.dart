import 'package:flutter/material.dart';
import 'package:apphud/models/apphud_models/apphud_product.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/button.dart';

class VipTile extends StatelessWidget {
  const VipTile({
    super.key,
    required this.product,
    required this.current,
    required this.loading,
    required this.onPressed,
  });

  final ApphudProduct product;
  final ApphudProduct? current;
  final bool loading;
  final void Function(ApphudProduct) onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final active = current == product;

    return AnimatedContainer(
      duration: const Duration(milliseconds: Constants.milliseconds),
      height: 70,
      margin: const EdgeInsets.only(bottom: Constants.padding),
      decoration: BoxDecoration(
        color: colors.tile,
        borderRadius: BorderRadius.circular(Constants.radius),
        border: Border.all(
          width: 2,
          color: active ? colors.accent : colors.tile,
        ),
      ),
      child: Button(
        onPressed: loading
            ? null
            : () {
                onPressed(product);
              },
        child: Row(
          children: [
            const SizedBox(width: Constants.padding),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    product.productDetails?.title ?? 'title',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colors.text,
                      fontSize: 16,
                      fontFamily: AppFonts.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.productDetails?.description ?? 'description',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colors.text2,
                      fontSize: 14,
                      fontFamily: AppFonts.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: Constants.padding),
            Text(
              product.skProduct?.price.toString() ?? 'price',
              style: TextStyle(
                color: colors.text,
                fontSize: 20,
                fontFamily: AppFonts.w700,
              ),
            ),
            const SizedBox(width: Constants.padding),
          ],
        ),
      ),
    );
  }
}
