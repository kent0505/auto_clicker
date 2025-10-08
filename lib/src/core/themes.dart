import 'package:flutter/material.dart';

import 'constants.dart';

final _ligthColors = MyColors.dark();

final theme = ThemeData(
  useMaterial3: false,
  brightness: Brightness.dark,
  fontFamily: AppFonts.w400,
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColors.accent,
    selectionColor: AppColors.accent,
    selectionHandleColor: AppColors.accent,
  ),

  // OVERSCROLL
  colorScheme: const ColorScheme.dark(
    primary: AppColors.text,
    secondary: AppColors.tile, // overscroll
    surface: AppColors.bg, // bg color when push
  ),

  // SCAFFOLD
  scaffoldBackgroundColor: AppColors.bg,

  // DIALOG
  dialogTheme: const DialogThemeData(
    insetPadding: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(Constants.radius)),
    ),
  ),

  // TEXTFIELD
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    contentPadding: const EdgeInsets.symmetric(
      vertical: Constants.padding,
      horizontal: Constants.padding,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Constants.radius),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Constants.radius),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Constants.radius),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    hintStyle: const TextStyle(
      color: AppColors.tile,
      fontSize: 14,
      fontFamily: AppFonts.w400,
    ),
  ),
  extensions: [_ligthColors],
);
