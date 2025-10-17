import 'package:flutter/material.dart';

import '../../../core/constants.dart';

class GuideTitle extends StatelessWidget {
  const GuideTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Text(
      title,
      style: TextStyle(
        color: colors.text,
        fontSize: 20,
        fontFamily: AppFonts.w700,
      ),
    );
  }
}
