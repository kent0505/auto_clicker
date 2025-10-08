import 'dart:developer' as developer;

import 'package:flutter/material.dart';

void logger(Object message) {
  developer.log(message.toString());
}

int getTimestamp() {
  return DateTime.now().millisecondsSinceEpoch ~/ 1000;
}

Widget errorBuilder(
  BuildContext context,
  Object error,
  StackTrace? stackTrace,
) {
  logger(error);

  return const SizedBox();
}

Widget frameBuilder(
  BuildContext context,
  Widget child,
  int? frame,
  bool wasSynchronouslyLoaded,
) {
  return AnimatedOpacity(
    opacity: frame == null ? 0.0 : 1.0,
    duration: const Duration(milliseconds: 1000),
    curve: Curves.easeInOut,
    child: child,
  );
}
