import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/core/service_locator.dart';
import 'package:task2/feature/map/presentation/manager/map_bloc.dart';
import 'package:task2/feature/map/presentation/manager/map_event.dart';

import 'core/constants/app_theme.dart';
import 'feature/map/presentation/pages/map_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  serviceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MapBloc(
        getRouteUsecase: locator(),
        searchLocationUsecase: locator(),
        convertLattngUsecase: locator(),
      )..add(GetCurrentLocationEvent()),
      child: MaterialApp(
        title: 'Ober',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: appLightThemeData,
        home: MapPage(),
      ),
    );
  }
}
