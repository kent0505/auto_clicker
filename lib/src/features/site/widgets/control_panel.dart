import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/icon_widget.dart';
import '../../clicker/bloc/clicker_bloc.dart';
import '../../clicker/widgets/settings_sheet.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel({
    super.key,
    required this.controller,
    required this.started,
    required this.onStart,
    required this.onStop,
  });

  final bool started;
  final WebViewController controller;
  final VoidCallback onStart;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 60,
        color: AppColors.bg,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Button(
              onPressed: () async {
                if (await controller.canGoBack()) {
                  await controller.goBack();
                }
              },
              child: const IconWidget(Icons.arrow_back_ios_new_rounded),
            ),
            Button(
              onPressed: () async {
                if (await controller.canGoForward()) {
                  await controller.goForward();
                }
              },
              child: const IconWidget(Icons.arrow_forward_ios_rounded),
            ),
            Button(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const SettingsSheet();
                  },
                );
              },
              child: const IconWidget(Icons.settings_rounded),
            ),
            Button(
              onPressed: started
                  ? null
                  : () {
                      context.read<ClickerBloc>().add(ResetClicks());
                    },
              child: const IconWidget(Icons.restart_alt_rounded),
            ),
            BlocBuilder<ClickerBloc, ClickerState>(
              builder: (context, state) {
                final color =
                    state.clicks.length < 5 ? AppColors.text : AppColors.tile;

                return Button(
                  onPressed: state.clicks.length < 5 && !started
                      ? () {
                          context.read<ClickerBloc>().add(AddClick());
                        }
                      : null,
                  child: Stack(
                    children: [
                      IconWidget(
                        Icons.touch_app,
                        color: color,
                      ),
                      Text(
                        (5 - state.clicks.length).toString(),
                        style: TextStyle(
                          color: color,
                          fontSize: 12,
                          fontFamily: AppFonts.w600,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Button(
              onPressed: started ? onStop : onStart,
              child: IconWidget(
                started ? Icons.stop_rounded : Icons.play_arrow_rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
