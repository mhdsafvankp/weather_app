import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/application/bloc/splash_bloc.dart';
import 'package:weather_app/domain/common/logger.dart';
import 'package:weather_app/presentation/bloc/events/auth_event.dart';
import 'package:weather_app/presentation/bloc/events/splash_event.dart';
import 'package:weather_app/presentation/bloc/states/auth_state.dart';
import 'package:weather_app/presentation/bloc/states/splash_state.dart';
import 'package:weather_app/routes/app_router.dart';


@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}): super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    print('initState : initState');
    context.read<SplashBloc>().add(LoadSplashScreen());
  }


  @override
  Widget build(BuildContext context) {
    print('build : build');
    return Scaffold(
        body: SafeArea(
            child: BlocListener<SplashBloc, SplashState>(
                listener: (context, state) {
                  logPrint('BlocListener -> SplashBloc state: ${state.runtimeType}');
                   if (state is LoadedSplash) {
                    AutoRouter.of(context).replace(AuthLoginRoute());
                  }
                },
                child: const Center(child: Text('Splash screen')))));
  }
}
