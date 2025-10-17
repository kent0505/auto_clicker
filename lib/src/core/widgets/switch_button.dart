import 'package:flutter/material.dart';

import '../constants.dart';
import 'button.dart';

class SwitchButton extends StatelessWidget {
  const SwitchButton({
    super.key,
    required this.isActive,
    required this.onPressed,
  });

  final bool isActive;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        height: 22,
        width: 40,
        decoration: BoxDecoration(
          color: isActive ? colors.accent : colors.tile,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Button(
          onPressed: onPressed,
          minSize: 22,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                top: 3,
                left: isActive ? 21 : 3,
                child: Container(
                  height: 16,
                  width: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isActive ? colors.text : colors.bg,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
