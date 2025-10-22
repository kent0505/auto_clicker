import 'package:flutter/cupertino.dart';

export './my_colors.dart';
// final colors = Theme.of(context).extension<MyColors>()!;

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
  static const int milliseconds = 400;
}

abstract final class Assets {
  static const String icon = 'assets/icon.png';
  static const String logo1 = 'assets/logo1.png';
  static const String logo2 = 'assets/logo2.png';
  static const String logo3 = 'assets/logo3.png';
  static const String logo4 = 'assets/logo4.png';
  static const String logo5 = 'assets/logo5.png';
  static const String logo6 = 'assets/logo6.png';
  static const String logo7 = 'assets/logo7.png';
  static const String onb1 = 'assets/onb1.png';
  static const String onb2 = 'assets/onb2.png';
  static const String onb3 = 'assets/onb3.png';

  static const String guide1 = 'assets/guides/guide1.jpg';
  static const String guide2 = 'assets/guides/guide2.jpg';
  static const String guide3 = 'assets/guides/guide3.jpg';
  static const String guide4 = 'assets/guides/guide4.jpg';
  static const String guide5 = 'assets/guides/guide5.jpg';
  static const String guide6 = 'assets/guides/guide6.jpg';
  static const String guide7 = 'assets/guides/guide7.jpg';
  static const String guide8 = 'assets/guides/guide8.jpg';
  static const String guide9 = 'assets/guides/guide9.jpg';
  static const String guide10 = 'assets/guides/guide10.jpg';
  static const String guide11 = 'assets/guides/guide11.jpg';
  static const String guide12 = 'assets/guides/guide12.jpg';
  static const String guide13 = 'assets/guides/guide13.PNG';
  static const String guide14 = 'assets/guides/guide14.jpg';
  static const String guide15 = 'assets/guides/guide15.jpg';
  static const String guide16 = 'assets/guides/guide16.jpg';
  static const String guide17 = 'assets/guides/guide17.jpg';
  static const String guide18 = '';
  static const String guide19 = '';
}

abstract final class MyIcons {
  static const IconData add = CupertinoIcons.add;
  static const IconData delete = CupertinoIcons.delete;
  static const IconData back = CupertinoIcons.back;
  static const IconData close = CupertinoIcons.xmark;
  static const IconData home = CupertinoIcons.home;
  static const IconData info = CupertinoIcons.info;
  static const IconData settings = CupertinoIcons.settings;
  static const IconData forward = CupertinoIcons.forward;
  static const IconData restart = CupertinoIcons.restart;
  static const IconData play = CupertinoIcons.play;
  static const IconData stop = CupertinoIcons.stop;
  static const IconData circle = CupertinoIcons.circle;
  static const IconData move = CupertinoIcons.move;
  static const IconData shield = CupertinoIcons.shield;
  static const IconData docText = CupertinoIcons.doc_text;
  static const IconData questionCircle = CupertinoIcons.question_circle;
  static const IconData lightbulb = CupertinoIcons.lightbulb;
  static const IconData checkMark = CupertinoIcons.check_mark;
  static const IconData chevronRight = CupertinoIcons.chevron_right;
}

abstract final class Keys {
  static const String onboard = 'onboard';
  static const String themeID = 'themeID';
}
