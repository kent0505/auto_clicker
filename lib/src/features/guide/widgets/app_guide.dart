import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/icon_widget.dart';
import 'guide_title.dart';

class AppGuide extends StatelessWidget {
  const AppGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(Constants.padding),
      children: const [
        GuideTitle('Controll panel'),
        _IconGuide(
          icon: MyIcons.play,
          title: 'Start click/swipe',
        ),
        _IconGuide(
          icon: MyIcons.hand,
          quarterTurns: 1,
          title:
              'Add an additional click area, a maximum of 5 can be added, each area is triggered in turn. To remove it, just click on it',
        ),
        _IconGuide(
          icon: MyIcons.settings,
          title: 'Open advanced settings',
        ),
        _IconGuide(
          icon: MyIcons.back,
          title: 'Navigate to the previous page in history',
        ),
        _IconGuide(
          icon: MyIcons.forward,
          title: 'Navigate to the next page in history',
        ),
        SizedBox(height: 8),
        GuideTitle('Advanced settings'),
        _AdvancedGuide(
          title: 'Click Interval (sec)',
          description:
              'Interval seconds between clicks, minimum 0.1, maximum 10',
        ),
        _AdvancedGuide(
          title: 'Repeat count',
          description: 'Number of repetitions',
        ),
        _AdvancedGuide(
          title: 'Endless',
          description: 'Runs endlessly until stopped manually',
        ),
        _AdvancedGuide(
          title: 'Double click',
          description: 'Each click will be double',
        ),
        _AdvancedGuide(
          title: 'Swipe mode',
          description:
              'Swipe the page in the direction where the indicator is located',
        ),
      ],
    );
  }
}

class _Description extends StatelessWidget {
  const _Description(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Text(
      title,
      style: TextStyle(
        color: colors.text,
        fontSize: 14,
        fontFamily: AppFonts.w500,
        height: 1,
      ),
    );
  }
}

class _AdvancedGuide extends StatelessWidget {
  const _AdvancedGuide({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(
            color: colors.text,
            fontSize: 18,
            fontFamily: AppFonts.w600,
          ),
        ),
        const SizedBox(height: 4),
        _Description(description),
      ],
    );
  }
}

class _IconGuide extends StatelessWidget {
  const _IconGuide({
    required this.icon,
    required this.title,
    this.quarterTurns = 0,
  });

  final IconData icon;
  final String title;
  final int quarterTurns;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          RotatedBox(
            quarterTurns: quarterTurns,
            child: IconWidget(icon),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _Description(title),
          ),
        ],
      ),
    );
  }
}
