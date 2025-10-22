import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import 'guide_title.dart';

class SwitchControlGuide extends StatelessWidget {
  const SwitchControlGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(Constants.padding),
      children: const [
        GuideTitle('Setting up an Auto Clicker with Switch Control'),
        SizedBox(height: 8),
        _Text('Open the Settings app, go to Accessibility, and tap it'),
        _Image(Assets.guide1),
        _Text('On the Accessibility screen, tap Switch Control'),
        _Image(Assets.guide2),
        _Text('Next, choose Switches'),
        _Image(Assets.guide3),
        _Text('Then, tap Add New Switch...'),
        _Image(Assets.guide4),
        _Text('Select Screen as the switch source'),
        _Image(Assets.guide5),
        _Text('Tap Full Screen'),
        _Image(Assets.guide6),
        _Text('Choose Tap as the action'),
        _Image(Assets.guide7),
        _Text('Go back to the main Switch Control screen, then tap Recipes'),
        _Image(Assets.guide8),
        _Text('Tap Create New Recipe'),
        _Image(Assets.guide9),
        _Text('Enter a name for your recipe, then tap Assign a Switch'),
        _Image(Assets.guide10),
        _Text('Choose Full Screen'),
        _Image(Assets.guide11),
        _Text('Select Custom Gesture'),
        _Image(Assets.guide12),
        _Text(
          'To create your auto-click gesture, quickly tap on the screen where you want the clicks to happen in Roblox.\n\nWhen done, tap Save',
        ),
        _Image(Assets.guide13),
        _Text('Go back to the Recipes screen and tap Launch Recipe'),
        _Image(Assets.guide14),
        _Text('Select the recipe you just created.'),
        _Image(Assets.guide15),
        _Text('Return to Accessibility and tap Accessibility Shortcut'),
        _Image(Assets.guide16),
        _Text('Select Switch Control'),
        _Image(Assets.guide17),
        _Text(
            'Your auto clicker setup is complete! You can now start using it\n'),
        _Text(
          'Press the side button three times to open the menu, then select Switch Control.',
        ),
        _Text(
          'In the game, tap the area where you want to click. Make sure one of your taps is repeated — after that, keep tapping and the clicks will automatically repeat.',
        ),
      ],
    );
  }
}

class _Image extends StatelessWidget {
  const _Image(this.asset);

  final String asset;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(vertical: 8),
      child: Image.asset(
        asset,
        frameBuilder: frameBuilder,
      ),
    );
  }
}

class _Text extends StatelessWidget {
  const _Text(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Text(
      text,
      style: TextStyle(
        color: colors.text,
        fontSize: 18,
        fontFamily: AppFonts.w500,
      ),
    );
  }
}
