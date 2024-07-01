import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/application/bloc/auth_bloc.dart';
import 'package:weather_app/application/bloc/splash_bloc.dart';
import 'package:weather_app/application/bloc/weather_bloc.dart';
import 'package:weather_app/routes/app_router.dart';

import 'locator.dart' as di;
import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.initLocator();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<AuthBloc>(
      create: (BuildContext context) => locator<AuthBloc>(),
    ),
    BlocProvider<SplashBloc>(
      create: (BuildContext context) => locator<SplashBloc>(),
    ),
    BlocProvider<WeatherBloc>(
      create: (BuildContext context) => locator<WeatherBloc>(),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Weather APP',
      routerConfig: _appRouter.config(),
    );
  }
}
