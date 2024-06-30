import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/locator.dart';
import 'package:weather_app/presentation/bloc/events/auth_event.dart';
import 'package:weather_app/presentation/bloc/states/auth_state.dart';

import '../../application/bloc/auth_bloc.dart';

@RoutePage()
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
      builder: (BuildContext context, state) {
        if (state is UnAuthenticated) {
          return Center(
              child: TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(SingInRequested(
                        email: 'test123@gmail.com', password: '123456'));
                  },
                  child: Text('Login')));
        }
        return CircularProgressIndicator();
      },
      listener: (BuildContext context, AuthState state) {
        print('state --> ${state.runtimeType}');
        if (state is Authenticated) {
          print('Authenticated --> true');
        }
      },
    ));
  }
}
