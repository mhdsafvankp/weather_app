
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';

import '../presentation/screens/auth_screen.dart';
import '../presentation/screens/splash_screen.dart';
import '../presentation/screens/weather_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter{

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: AuthRoute.page),
    AutoRoute(page: WeatherRoute.page)
  ];


}