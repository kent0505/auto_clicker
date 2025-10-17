import 'package:flutter/material.dart';

import '../../../core/widgets/tab_widget.dart';
import '../widgets/switch_control_guide.dart';
import '../widgets/app_guide.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabWidget(
      titles: ['App', 'Clicker for games'],
      pages: [
        AppGuide(),
        SwitchControlGuide(),
      ],
    );
  }
}
