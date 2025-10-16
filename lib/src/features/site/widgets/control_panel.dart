import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/icon_widget.dart';
import '../../clicker/bloc/clicker_bloc.dart';
import 'advanced_settings_sheet.dart';

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
              child: const IconWidget(CupertinoIcons.back),
            ),
            Button(
              onPressed: () async {
                if (await controller.canGoForward()) {
                  await controller.goForward();
                }
              },
              child: const IconWidget(CupertinoIcons.forward),
            ),
            Button(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return AdvancedSettingsSheet(controller: controller);
                  },
                );
              },
              child: const IconWidget(CupertinoIcons.settings),
            ),
            Button(
              onPressed: started
                  ? null
                  : () {
                      context.read<ClickerBloc>().add(ResetClicks());
                    },
              child: const IconWidget(CupertinoIcons.restart),
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
                    alignment: Alignment.center,
                    children: [
                      IconWidget(
                        CupertinoIcons.circle,
                        color: color,
                      ),
                      Positioned(
                        top: 8,
                        left: 11,
                        child: Text(
                          (5 - state.clicks.length).toString(),
                          style: TextStyle(
                            color: color,
                            fontSize: 12,
                            fontFamily: AppFonts.w600,
                          ),
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
                started ? CupertinoIcons.stop : CupertinoIcons.play,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
