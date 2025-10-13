import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/dialog_widget.dart';
import '../../../core/widgets/icon_widget.dart';
import '../../../core/widgets/switch_button.dart';
import '../../../core/widgets/add_button.dart';
import '../../site/bloc/site_bloc.dart';
import '../../site/models/site.dart';
import '../bloc/clicker_bloc.dart';

class SettingsSheet extends StatelessWidget {
  const SettingsSheet({super.key, required this.controller});

  final WebViewController controller;

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
              ],
            ),
          ),
          SizedBox(
            height: 44,
            child: Row(
              children: [
                const _Title('Swipe mode'),
                const Spacer(),
                BlocBuilder<ClickerBloc, ClickerState>(
                  builder: (context, state) {
                    return SwitchButton(
                      isActive: state.swipeMode,
                      onPressed: () {
                        context.read<ClickerBloc>().add(ChangeSwipeMode());
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          AddButton(
            title: 'Save url',
            onPressed: () async {
              final url = (await controller.currentUrl() ?? '');
              final title =
                  url.replaceAll('https://', '').replaceAll('www.', '');

              if (context.mounted) {
                DialogWidget.show(
                  context,
                  title: 'Save url $title?',
                  confirm: true,
                  onPressed: () {
                    final site = Site(
                      title: title,
                      url: url,
                    );
                    context.read<SiteBloc>().add(AddSite(site: site));

                    context.pop();
                  },
                );
              }
            },
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
