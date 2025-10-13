import 'package:auto_clicker/src/core/widgets/switch_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/icon_widget.dart';
import '../bloc/clicker_bloc.dart';

class SettingsSheet extends StatelessWidget {
  const SettingsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Constants.padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const _Title('Click Interval (sec)'),
              const Spacer(),
              const _ChangeIntervalButton(increment: false),
              BlocBuilder<ClickerBloc, ClickerState>(
                builder: (context, state) {
                  return _AmountText(
                      amount: (state.interval / 1000)
                          .toStringAsFixed(1)
                          .replaceAll('.0', ''));
                },
              ),
              const _ChangeIntervalButton(increment: true),
            ],
          ),
          Row(
            children: [
              const _Title('Repeat count'),
              const Spacer(),
              const _ChangeRepeatButton(increment: false),
              BlocBuilder<ClickerBloc, ClickerState>(
                builder: (context, state) {
                  return _AmountText(amount: state.repeat.toString());
                },
              ),
              const _ChangeRepeatButton(increment: true),
            ],
          ),
          SizedBox(
            height: 44,
            child: Row(
              children: [
                const _Title('Double click'),
                const Spacer(),
                BlocBuilder<ClickerBloc, ClickerState>(
                  builder: (context, state) {
                    return SwitchButton(
                      isActive: state.doubleClick,
                      onPressed: () {
                        context.read<ClickerBloc>().add(ChangeDoubleClick());
                      },
                    );
                  },
                ),
                // const SizedBox(width: 44),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.text,
        fontSize: 16,
        fontFamily: AppFonts.w600,
      ),
    );
  }
}

class _AmountText extends StatelessWidget {
  const _AmountText({required this.amount});

  final String amount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      child: Text(
        amount,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: AppColors.text,
          fontSize: 16,
          fontFamily: AppFonts.w600,
        ),
      ),
    );
  }
}

class _ChangeIntervalButton extends StatelessWidget {
  const _ChangeIntervalButton({required this.increment});

  final bool increment;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClickerBloc, ClickerState>(
      builder: (context, state) {
        final active = increment ? state.interval < 5000 : state.interval > 100;
        final color = active ? AppColors.text : AppColors.tile;

        return Button(
          onPressed: active
              ? () {
                  context.read<ClickerBloc>().add(
                        ChangeInterval(
                          interval: increment
                              ? state.interval + 100
                              : state.interval - 100,
                        ),
                      );
                }
              : null,
          child: IconWidget(
            increment
                ? Icons.chevron_right_rounded
                : Icons.chevron_left_rounded,
            color: color,
          ),
        );
      },
    );
  }
}

class _ChangeRepeatButton extends StatelessWidget {
  const _ChangeRepeatButton({required this.increment});

  final bool increment;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClickerBloc, ClickerState>(
      builder: (context, state) {
        final active = increment ? state.repeat < 1000 : state.repeat > 1;
        final color = active ? AppColors.text : AppColors.tile;

        return Button(
          onPressed: active
              ? () {
                  context.read<ClickerBloc>().add(
                        ChangeRepeat(
                          repeat:
                              increment ? state.repeat + 1 : state.repeat - 1,
                        ),
                      );
                }
              : null,
          child: IconWidget(
            increment
                ? Icons.chevron_right_rounded
                : Icons.chevron_left_rounded,
            color: color,
          ),
        );
      },
    );
  }
}
