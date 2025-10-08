import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../screens/add_site_screen.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: () {
        context.push(AddSiteScreen.routePath);
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.tile,
          borderRadius: BorderRadius.circular(Constants.radius),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgWidget(
              Assets.add,
              color: AppColors.text,
            ),
            SizedBox(width: 10),
            Text(
              'Add site',
              style: TextStyle(
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
