import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils.dart';
import '../../../core/constants.dart';
import '../../guide/screens/instruction_screen.dart';
import '../../settings/screens/settings_screen.dart';
import '../../site/screens/sites_screen.dart';
import '../widgets/home_appbar.dart';
import '../bloc/home_bloc.dart';
import '../widgets/nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routePath = '/HomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const HomeAppbar(),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: Constants.navBarHeight +
                  Constants.padding +
                  MediaQuery.of(context).viewPadding.bottom,
            ),
            child: BlocConsumer<HomeBloc, HomeState>(
              listener: (context, state) {
                logger(state.runtimeType);
              },
              buildWhen: (previous, current) {
                return previous.runtimeType != current.runtimeType;
              },
              builder: (context, state) {
                return IndexedStack(
                  index: switch (state) {
                    HomeInitial() => 0,
                    HomeGuides() => 1,
                    HomeSettings() => 2,
                  },
                  children: const [
                    SitesScreen(),
                    InstructionScreen(),
                    SettingsScreen(),
                  ],
                );
              },
            ),
          ),
          const NavBar(),
        ],
      ),
    );
  }
}
