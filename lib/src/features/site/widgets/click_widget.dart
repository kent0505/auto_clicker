import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../clicker/bloc/clicker_bloc.dart';
import '../../clicker/models/click.dart';

class ClickWidget extends StatelessWidget {
  const ClickWidget({
    super.key,
    required this.index,
    required this.click,
  });

  final int index;
  final Click click;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ClickerBloc>();
    final clicks = bloc.state.clicks;

    return Positioned(
      left: click.x,
      top: click.y,
      child: GestureDetector(
        onTap: clicks.length == 1
            ? null
            : () {
                bloc.add(RemoveClick(click: click));
              },
        onPanUpdate: (details) {
          click.x += details.delta.dx;
          click.y += details.delta.dy;

          bloc.add(MoveClick(click: click));
        },
        child: Stack(
          children: [
            Icon(
              bloc.state.swipeMode
                  ? Icons.open_with_rounded
                  : Icons.touch_app_rounded,
              color: AppColors.error,
              size: click.clicked ? 50 : 60,
            ),
            if (!click.clicked && clicks.length > 1)
              Positioned(
                right: bloc.state.swipeMode ? 26 : 20,
                bottom: bloc.state.swipeMode ? 21 : 6,
                child: Text(
                  (index + 1).toString(),
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 14,
                    fontFamily: AppFonts.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
