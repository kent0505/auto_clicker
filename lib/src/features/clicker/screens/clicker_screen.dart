import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';

class ClickerScreen extends StatefulWidget {
  const ClickerScreen({
    super.key,
    required this.url,
  });

  final String url;

  static const routePath = '/ClickerScreen';

  @override
  State<ClickerScreen> createState() => _ClickerScreenState();
}

class _ClickerScreenState extends State<ClickerScreen> {
  late final WebViewController controller;

  double x = 100;
  double y = 200;

  void onStart() async {
    final js = """
      (function() {
        const el = document.elementFromPoint($x, $y);
        if (el) {
          el.click();
          console.log('Clicked element:', el);
          return 'Clicked at ($x, $y)';
        } else {
          console.log('No element found at ($x, $y)');
          return 'No element found at ($x, $y)';
        }
      })();
    """;

    await controller.runJavaScript(js);
  }

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const Appbar(title: 'Clicker'),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  right: -0.5,
                  bottom: 0,
                  top: 0,
                  left: 0,
                  child: WebViewWidget(controller: controller),
                ),

                //
                Positioned(
                  left: x,
                  top: y,
                  child: GestureDetector(
                    onPanEnd: (details) {
                      logger(x);
                      logger(y);
                    },
                    onPanUpdate: (details) {
                      setState(() {
                        x += details.delta.dx;
                        y += details.delta.dy;

                        x = x.clamp(0, size.width - 60);
                        y = y.clamp(0, size.height - 60);
                      });
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: const Icon(
                        Icons.touch_app,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 60,
            color: AppColors.bg,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button(
                  onPressed: onStart,
                  child: const Text(
                    'Start',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: AppFonts.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
