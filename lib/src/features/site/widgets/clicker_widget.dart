import 'package:flutter/material.dart';

import '../../../core/constants.dart';

class ClickerWidget extends StatelessWidget {
  const ClickerWidget({super.key, required this.onPanUpdate});

  final void Function(DragUpdateDetails)? onPanUpdate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: onPanUpdate,
      child: const Icon(
        Icons.touch_app,
        color: AppColors.accent,
        size: 60,
      ),
    );
  }
}
