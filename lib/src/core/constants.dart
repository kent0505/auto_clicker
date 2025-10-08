import 'package:flutter/material.dart';

export './my_colors.dart';

abstract final class AppColors {
  static const Color accent = Color(0xff715A5A);
  static const Color error = Colors.redAccent;
  static const Color bg = Color(0xff37353E);
  static const Color tile = Color(0xff44444E);
  static const Color text = Color(0xffD3DAD9);
  static Color text2 = const Color(0xffD3DAD9).withValues(alpha: 0.4);
}

abstract final class AppFonts {
  static const String w400 = 'w400';
  static const String w500 = 'w500';
  static const String w600 = 'w600';
  static const String w700 = 'w700';
}

abstract final class Constants {
  static const double appBarHeight = 60;
  static const double navBarHeight = 62;
  static const double padding = 16;
  static const double radius = 10;
}

abstract final class Assets {
  static const String add = 'assets/add.svg';
  static const String back = 'assets/back.svg';
  static const String logo1 = 'assets/logo1.png';
  static const String logo2 = 'assets/logo2.png';
  static const String logo3 = 'assets/logo3.png';
}

abstract final class Keys {
  static const String onboard = 'onboard';
  static const String token = 'token';
}

abstract final class Identifiers {
  static const paywall1 = 'paywall_1';
  static const paywall2 = 'paywall_2';
}

enum Roles { admin, user }

// final colors = Theme.of(context).extension<MyColors>()!;
