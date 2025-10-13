import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'src/core/router.dart';
import 'src/core/themes.dart';
import 'src/features/clicker/bloc/clicker_bloc.dart';
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

  // await Purchases.configure(
  //   PurchasesConfiguration(''),
  // );

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
        RepositoryProvider<SiteRepository>(
          create: (context) => SiteRepositoryImpl(db: db),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeBloc()),
          BlocProvider(create: (context) => VipBloc()),
          BlocProvider(create: (context) => ClickerBloc()),
          BlocProvider(
            create: (context) => SiteBloc(
              repository: context.read<SiteRepository>(),
            )..add(GetSites()),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: theme,
          routerConfig: routerConfig,
        ),
      ),
    ),
  );
}
