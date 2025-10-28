import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../guide/screens/guide_screen.dart';
import '../../settings/screens/settings_screen.dart';
import '../../site/screens/sites_screen.dart';
import '../../vip/widgets/vip_listener.dart';
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
            padding: const EdgeInsets.only(
              bottom: Constants.navBarHeight + Constants.padding,
            ),
            child: BlocBuilder<HomeBloc, int>(
              buildWhen: (previous, current) {
                return previous != current;
              },
              builder: (context, state) {
                return IndexedStack(
                  index: state,
                  children: const [
                    SitesScreen(),
                    GuideScreen(),
                    SettingsScreen(),
                  ],
                );
              },
            ),
          ),
          const NavBar(),
          const VipListener(child: SizedBox()),
        ],
      ),
    );
  }
}
