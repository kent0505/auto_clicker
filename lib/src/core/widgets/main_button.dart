import 'package:flutter/material.dart';

import '../constants.dart';
import 'button.dart';
import 'loading_widget.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.title,
    this.width,
    this.horizontal = 0,
    this.color,
    this.active = true,
    this.loading = false,
    required this.onPressed,
  });

  final String title;
  final double? width;
  final double horizontal;
  final Color? color;
  final bool active;
  final bool loading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      height: 56,
      width: width,
      margin: EdgeInsets.symmetric(horizontal: horizontal),
      decoration: BoxDecoration(
        color: color ?? (active ? colors.accent : colors.tile),
        borderRadius: BorderRadius.circular(Constants.radius),
      ),
      child: Button(
        onPressed: active && !loading ? onPressed : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            loading
                ? const LoadingWidget()
                : Text(
                    title,
                    style: TextStyle(
                      color: active ? colors.text : colors.text2,
                      fontSize: 16,
                      fontFamily: AppFonts.w700,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
