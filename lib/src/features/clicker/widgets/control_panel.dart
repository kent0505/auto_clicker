import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/button.dart';
import '../bloc/clicker_bloc.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel({super.key, required this.onStart});

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: AppColors.bg,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Button(
            onPressed: () {
              context.read<ClickerBloc>().add(ChangeClickerPosition(100, 200));
              // showModalBottomSheet(
              //   context: context,
              //   builder: (context) {
              //     return Container();
              //   },
              // );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Reset',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 20,
                  fontFamily: AppFonts.w700,
                ),
              ),
            ),
          ),
          // Button(
          //   onPressed: () {
          //     context.read<ClickerBloc>().add(ChangeClickerPosition(100, 200));
          //   },
          //   child: const Icon(
          //     Icons.restart_alt_rounded,
          //     color: AppColors.text,
          //     size: 30,
          //   ),
          // ),
          // const Spacer(),
          Button(
            onPressed: onStart,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Start',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 20,
                  fontFamily: AppFonts.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
