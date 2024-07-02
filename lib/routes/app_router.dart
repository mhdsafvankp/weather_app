
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../presentation/screens/auth_login_screen.dart';
import '../presentation/screens/auth_sign_up_screen.dart';
import '../presentation/screens/location_details_screen.dart';
import '../presentation/screens/splash_screen.dart';
import '../presentation/screens/weather_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter{

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: AuthLoginRoute.page),
    AutoRoute(page: AuthSignUpRoute.page),
    AutoRoute(page: WeatherRoute.page),
    AutoRoute(page: LocationDetailsRoute.page)
  ];


}