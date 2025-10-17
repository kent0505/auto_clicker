import 'package:flutter/material.dart';

import '../constants.dart';

class Snack {
  const Snack._();

  static void show(
    BuildContext context, {
    required String message,
    bool isError = false,
  }) {
    final colors = Theme.of(context).extension<MyColors>()!;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.transparent,
        margin: const EdgeInsets.only(
          bottom: 100,
          left: 40,
          right: 40,
        ),
        behavior: SnackBarBehavior.floating,
        content: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: isError ? colors.error : colors.accent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colors.text,
                fontSize: 14,
                fontFamily: AppFonts.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
