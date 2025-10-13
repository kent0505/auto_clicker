import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebWidget extends StatelessWidget {
  const WebWidget({super.key, required this.controller});

  final WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: -0.5, // чтобы убрать белую линию по краю
      bottom: 60,
      top: 0,
      left: 0,
      child: WebViewWidget(controller: controller),
    );
  }
}
