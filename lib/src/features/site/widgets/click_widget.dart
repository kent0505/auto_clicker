import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../clicker/bloc/clicker_bloc.dart';
import '../../clicker/models/click.dart';

class ClickWidget extends StatelessWidget {
  const ClickWidget(
      {super.key,
      required this.index,
      required this.click,
      required this.state});

  final int index;
  final Click click;
  final ClickerState state;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Positioned(
      left: click.x,
      top: click.y,
      child: GestureDetector(
        onTap: state.clicks.length == 1
            ? null
            : () {
                context.read<ClickerBloc>().add(RemoveClick(click: click));
              },
        onPanUpdate: (details) {
          click.x += details.delta.dx;
          click.y += details.delta.dy;
          context.read<ClickerBloc>().add(MoveClick(click: click));
        },
        child: Stack(
          children: [
            Icon(
              state.swipeMode ? MyIcons.move : MyIcons.circle,
              color: colors.error,
              size: click.clicked ? 50 : 60,
            ),
            if (!click.clicked && state.clicks.length > 1)
              Positioned(
                right: state.swipeMode ? 0 : 26,
                bottom: state.swipeMode ? 0 : 20,
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(
                    color: colors.error,
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
