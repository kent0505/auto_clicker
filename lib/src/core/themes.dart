import 'package:flutter/material.dart';

import 'constants.dart';

class Themes {
  final bool isDark;

  Themes({required this.isDark});

  MyColors get colors {
    return isDark ? MyColors.dark() : MyColors.light();
  }

  ThemeData get theme {
    return ThemeData(
      useMaterial3: false,
      brightness: isDark ? Brightness.dark : Brightness.light,
      fontFamily: AppFonts.w400,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colors.accent,
        selectionColor: colors.accent,
        selectionHandleColor: colors.accent,
      ),

      colorScheme: isDark
          ? ColorScheme.dark(
              primary: colors.text,
              secondary: colors.tile, // overscroll
              surface: colors.bg, // bg color when push
            )
          : ColorScheme.light(
              primary: colors.text,
              secondary: colors.tile,
              surface: colors.bg,
            ),

      // SCAFFOLD
      scaffoldBackgroundColor: colors.bg,

      // DIALOG
      dialogTheme: DialogThemeData(
        insetPadding: EdgeInsets.zero,
        backgroundColor: colors.tile,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Constants.radius)),
        ),
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colors.bg,
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
        hintStyle: TextStyle(
          color: colors.text2,
          fontSize: 16,
          fontFamily: AppFonts.w500,
        ),
      ),
      extensions: [colors],
    );
  }
}
