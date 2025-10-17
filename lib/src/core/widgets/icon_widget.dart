import 'package:flutter/material.dart';

import '../constants.dart';

class IconWidget extends StatelessWidget {
  const IconWidget(
    this.icon, {
    super.key,
    this.color,
  });

  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Icon(
      icon,
      size: 30,
      color: color ?? colors.text,
    );
  }
}
