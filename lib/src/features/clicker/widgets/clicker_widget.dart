import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../bloc/clicker_bloc.dart';

class ClickerWidget extends StatelessWidget {
  const ClickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClickerBloc, Clicker>(
      builder: (context, state) {
        return Positioned(
          left: state.x,
          top: state.y,
          child: GestureDetector(
            onPanUpdate: (details) {
              context.read<ClickerBloc>().add(ChangeClickerPosition(
                    state.x += details.delta.dx,
                    state.y += details.delta.dy,
                  ));
            },
            child: const Icon(
              Icons.touch_app,
              color: AppColors.accent,
              size: 60,
            ),
          ),
        );
      },
    );
  }
}
