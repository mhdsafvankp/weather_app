import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/bloc/events/auth_event.dart';
import 'package:weather_app/presentation/bloc/states/auth_state.dart';
import 'package:weather_app/routes/app_router.dart';

import '../../application/bloc/auth_bloc.dart';
import '../../locator.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    print('initState : initState');
    context.read<AuthBloc>().add(CheckAuthStatus());
  }


  @override
  Widget build(BuildContext context) {
    print('build : build');
    return Scaffold(
        body: SafeArea(
            child: BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  print('AuthState : ${state.runtimeType}');
                  if (state is Authenticated) {
                    AutoRouter.of(context).push(WeatherRoute());
                  } else if (state is UnAuthenticated) {
                    AutoRouter.of(context).push(AuthRoute());
                  } else if(state is AuthError){
                    print('AuthError : ${state.msg}');
                  }
                },
                child: Center(child: CircularProgressIndicator()))));
  }
}
