import 'package:flutter/material.dart';

import '../constants.dart';
import 'button.dart';
import 'icon_widget.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.tile,
          borderRadius: BorderRadius.circular(Constants.radius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const IconWidget(Icons.add_rounded),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.text,
                fontSize: 18,
                fontFamily: AppFonts.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
