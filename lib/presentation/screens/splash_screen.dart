import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/application/blocs/splash_bloc/splash_bloc.dart';
import 'package:weather_app/domain/common/logger.dart';
import 'package:weather_app/application/blocs/splash_bloc/splash_event.dart';
import 'package:weather_app/application/blocs/splash_bloc/splash_state.dart';
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
      backgroundColor: Colors.blue[100],
        body: SafeArea(
            child: BlocListener<SplashBloc, SplashState>(
                listener: (context, state) {
                  logPrint('BlocListener -> SplashBloc state: ${state.runtimeType}');
                   if (state is LoadedSplash) {
                    AutoRouter.of(context).replace(AuthLoginRoute());
                  }
                },
                child:  Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.cloud, size: 150, color: Colors.white,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Weather APP', style: Theme.of(context).textTheme.headlineMedium,),
                    )
                  ],
                )))
        ));
  }
}
