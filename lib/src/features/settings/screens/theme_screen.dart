import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/icon_widget.dart';
import '../bloc/settings_bloc.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  static const routePath = '/ThemeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(title: 'Theme'),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _ThemeButton(
                title: 'System',
                active: state.themeMode == ThemeMode.system,
                onPressed: () {
                  context.read<SettingsBloc>().add(SetTheme(id: 0));
                },
              ),
              _ThemeButton(
                title: 'Light',
                active: state.themeMode == ThemeMode.light,
                onPressed: () {
                  context.read<SettingsBloc>().add(SetTheme(id: 1));
                },
              ),
              _ThemeButton(
                title: 'Dark',
                active: state.themeMode == ThemeMode.dark,
                onPressed: () {
                  context.read<SettingsBloc>().add(SetTheme(id: 2));
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ThemeButton extends StatelessWidget {
  const _ThemeButton({
    required this.title,
    required this.active,
    required this.onPressed,
  });

  final String title;
  final bool active;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Container(
      height: 56,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: Constants.padding),
      decoration: BoxDecoration(
        color: colors.tile,
        borderRadius: BorderRadius.circular(Constants.radius),
      ),
      child: Button(
        onPressed: onPressed,
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: colors.text,
                  fontSize: 16,
                  fontFamily: AppFonts.w500,
                ),
              ),
            ),
            if (active)
              const SizedBox(
                width: 24,
                child: IconWidget(MyIcons.checkMark),
              ),
          ],
        ),
      ),
    );
  }
}
