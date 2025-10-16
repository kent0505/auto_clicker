import 'package:flutter/material.dart';

import '../../../core/constants.dart';

class SwitchControlGuide extends StatelessWidget {
  const SwitchControlGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(Constants.padding),
      children: const [
        _Text('Switch Control instruction'),
      ],
    );
  }
}

// class _Image extends StatelessWidget {
//   const _Image(this.asset);

//   final String asset;

//   @override
//   Widget build(BuildContext context) {
//     return Image.asset(asset);
//   }
// }

class _Text extends StatelessWidget {
  const _Text(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.text,
        fontSize: 14,
        fontFamily: AppFonts.w500,
        height: 1,
      ),
    );
  }
}
