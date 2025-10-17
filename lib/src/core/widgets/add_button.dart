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
    final colors = Theme.of(context).extension<MyColors>()!;

    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: colors.tile,
        borderRadius: BorderRadius.circular(Constants.radius),
      ),
      child: Button(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const IconWidget(MyIcons.add),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                color: colors.text,
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
