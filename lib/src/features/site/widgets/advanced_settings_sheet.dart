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
import '../../clicker/bloc/clicker_bloc.dart';
import '../bloc/site_bloc.dart';
import '../models/site.dart';

class AdvancedSettingsSheet extends StatelessWidget {
  const AdvancedSettingsSheet({super.key, required this.controller});

  final WebViewController controller;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ClickerBloc>().state;

    return Container(
      padding: const EdgeInsets.all(Constants.padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const _Title('Click Interval (sec)'),
              const Spacer(),
              _ChangeIntervalButton(
                increment: false,
                active: state.interval > 100,
                interval: state.interval - 100,
              ),
              _AmountText(
                amount: (state.interval / 1000)
                    .toStringAsFixed(1)
                    .replaceAll('.0', ''),
              ),
              _ChangeIntervalButton(
                increment: true,
                active: state.interval < 5000,
                interval: state.interval + 100,
              ),
            ],
          ),
          if (!state.endless)
            Row(
              children: [
                const _Title('Repeat count'),
                const Spacer(),
                _ChangeRepeatButton(
                  increment: false,
                  active: state.repeat > 1,
                  repeat: state.repeat - 1,
                ),
                _AmountText(amount: state.repeat.toString()),
                _ChangeRepeatButton(
                  increment: true,
                  active: state.repeat < 1000,
                  repeat: state.repeat + 1,
                ),
              ],
            ),
          SizedBox(
            height: 44,
            child: Row(
              children: [
                const _Title('Endless'),
                const Spacer(),
                SwitchButton(
                  isActive: state.endless,
                  onPressed: () {
                    context.read<ClickerBloc>().add(ChangeEndless());
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: 44,
            child: Row(
              children: [
                const _Title('Double click'),
                const Spacer(),
                SwitchButton(
                  isActive: state.doubleClick,
                  onPressed: () {
                    context.read<ClickerBloc>().add(ChangeDoubleClick());
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
                SwitchButton(
                  isActive: state.swipeMode,
                  onPressed: () {
                    context.read<ClickerBloc>().add(ChangeSwipeMode());
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
                    context.read<SiteBloc>().add(
                          AddSite(
                            site: Site(
                              title: title,
                              url: url,
                            ),
                          ),
                        );
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
  const _ChangeIntervalButton({
    required this.increment,
    required this.active,
    required this.interval,
  });

  final bool increment;
  final bool active;
  final int interval;

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: active
          ? () {
              context
                  .read<ClickerBloc>()
                  .add(ChangeInterval(interval: interval));
            }
          : null,
      child: IconWidget(
        increment ? Icons.chevron_right_rounded : Icons.chevron_left_rounded,
        color: active ? AppColors.text : AppColors.tile,
      ),
    );
  }
}

class _ChangeRepeatButton extends StatelessWidget {
  const _ChangeRepeatButton({
    required this.increment,
    required this.active,
    required this.repeat,
  });

  final bool increment;
  final bool active;
  final int repeat;

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: active
          ? () {
              context.read<ClickerBloc>().add(ChangeRepeat(repeat: repeat));
            }
          : null,
      child: IconWidget(
        increment ? Icons.chevron_right_rounded : Icons.chevron_left_rounded,
        color: active ? AppColors.text : AppColors.tile,
      ),
    );
  }
}
