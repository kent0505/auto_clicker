import 'package:go_router/go_router.dart';

import '../features/settings/screens/theme_screen.dart';
import '../features/site/screens/add_site_screen.dart';
import '../features/site/screens/site_screen.dart';
import '../features/site/models/site.dart';
import '../features/home/screens/home_screen.dart';
import '../features/onboard/screens/onboard_screen.dart';
import '../features/splash/screens/splash_screen.dart';

final routerConfig = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: OnboardScreen.routePath,
      builder: (context, state) => const OnboardScreen(),
    ),
    GoRoute(
      path: HomeScreen.routePath,
      builder: (context, state) => const HomeScreen(),
    ),

    // site
    GoRoute(
      path: SiteScreen.routePath,
      builder: (context, state) => SiteScreen(
        site: state.extra as Site,
      ),
    ),
    GoRoute(
      path: AddSiteScreen.routePath,
      builder: (context, state) => const AddSiteScreen(),
    ),

    // settings
    GoRoute(
      path: ThemeScreen.routePath,
      builder: (context, state) => const ThemeScreen(),
    ),
  ],
);
