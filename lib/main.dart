import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'src/core/router.dart';
import 'src/core/themes.dart';
import 'src/core/utils.dart';
import 'src/features/clicker/bloc/clicker_bloc.dart';
import 'src/features/settings/bloc/settings_bloc.dart';
import 'src/features/settings/data/settings_repository.dart';
import 'src/features/site/bloc/site_bloc.dart';
import 'src/features/site/data/site_repository.dart';
import 'src/features/home/bloc/home_bloc.dart';
import 'src/features/onboard/data/onboard_repository.dart';
import 'src/features/site/models/site.dart';
import 'src/features/vip/bloc/vip_bloc.dart';

// adb tcpip 5555 && adb connect 192.168.0.190

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Purchases.configure(
    PurchasesConfiguration(
      isIOS() ? 'ios_api_key' : 'android api key',
    ),
  );

  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();

  final path = join(await getDatabasesPath(), 'data.db');
  // await deleteDatabase(path);

  final db = await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      await db.execute(Site.create);
    },
  );

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<OnboardRepository>(
          create: (context) => OnboardRepositoryImpl(prefs: prefs),
        ),
        RepositoryProvider<SettingsRepository>(
          create: (context) => SettingsRepositoryImpl(prefs: prefs),
        ),
        RepositoryProvider<SiteRepository>(
          create: (context) => SiteRepositoryImpl(db: db),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeBloc()),
          BlocProvider(create: (context) => VipBloc()..add(CheckVip())),
          BlocProvider(create: (context) => ClickerBloc()),
          BlocProvider(
            create: (context) => SettingsBloc(
              repository: context.read<SettingsRepository>(),
            )..add(GetTheme()),
          ),
          BlocProvider(
            create: (context) => SiteBloc(
              repository: context.read<SiteRepository>(),
            )..add(GetSites()),
          ),
        ],
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              themeMode: state.themeMode,
              theme: Themes(isDark: false).theme,
              darkTheme: Themes(isDark: true).theme,
              routerConfig: routerConfig,
            );
          },
        ),
      ),
    ),
  );
}
