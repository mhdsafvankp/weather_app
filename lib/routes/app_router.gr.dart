// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AuthLoginRoute.name: (routeData) {
      final args = routeData.argsAs<AuthLoginRouteArgs>(
          orElse: () => const AuthLoginRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AuthLoginScreen(key: args.key),
      );
    },
    AuthSignUpRoute.name: (routeData) {
      final args = routeData.argsAs<AuthSignUpRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AuthSignUpScreen(
          key: args.key,
          email: args.email,
          password: args.password,
        ),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashScreen(),
      );
    },
    WeatherRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WeatherScreen(),
      );
    },
  };
}

/// generated route for
/// [AuthLoginScreen]
class AuthLoginRoute extends PageRouteInfo<AuthLoginRouteArgs> {
  AuthLoginRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          AuthLoginRoute.name,
          args: AuthLoginRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'AuthLoginRoute';

  static const PageInfo<AuthLoginRouteArgs> page =
      PageInfo<AuthLoginRouteArgs>(name);
}

class AuthLoginRouteArgs {
  const AuthLoginRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'AuthLoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [AuthSignUpScreen]
class AuthSignUpRoute extends PageRouteInfo<AuthSignUpRouteArgs> {
  AuthSignUpRoute({
    Key? key,
    required String email,
    required String password,
    List<PageRouteInfo>? children,
  }) : super(
          AuthSignUpRoute.name,
          args: AuthSignUpRouteArgs(
            key: key,
            email: email,
            password: password,
          ),
          initialChildren: children,
        );

  static const String name = 'AuthSignUpRoute';

  static const PageInfo<AuthSignUpRouteArgs> page =
      PageInfo<AuthSignUpRouteArgs>(name);
}

class AuthSignUpRouteArgs {
  const AuthSignUpRouteArgs({
    this.key,
    required this.email,
    required this.password,
  });

  final Key? key;

  final String email;

  final String password;

  @override
  String toString() {
    return 'AuthSignUpRouteArgs{key: $key, email: $email, password: $password}';
  }
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WeatherScreen]
class WeatherRoute extends PageRouteInfo<void> {
  const WeatherRoute({List<PageRouteInfo>? children})
      : super(
          WeatherRoute.name,
          initialChildren: children,
        );

  static const String name = 'WeatherRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
