import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/common/validator.dart';
import 'package:weather_app/locator.dart';
import 'package:weather_app/presentation/bloc/events/auth_event.dart';
import 'package:weather_app/presentation/bloc/states/auth_state.dart';
import 'package:weather_app/presentation/snack_bars.dart';
import 'package:weather_app/presentation/widgets/custom_text_button.dart';
import 'package:weather_app/presentation/widgets/custom_text_field.dart';
import 'package:weather_app/presentation/widgets/submit_button.dart';

import '../../application/bloc/auth_bloc.dart';
import '../../domain/common/constants.dart';
import '../../domain/common/logger.dart';
import '../../routes/app_router.dart';

@RoutePage()
class AuthLoginScreen extends StatefulWidget {
  AuthLoginScreen({Key? key}) : super(key: key);

  @override
  State<AuthLoginScreen> createState() => _AuthLoginScreenState();
}

class _AuthLoginScreenState extends State<AuthLoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passController = TextEditingController();


  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(CheckAuthStatus());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocConsumer<AuthBloc, AuthState>(
      builder: (BuildContext context, AuthState state){
        if(state is UnAuthenticated){
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: Text(
                          'Login',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      CustomTextField(
                        controller: emailController,
                        labelString: 'Email',
                        type: ValidateType.email,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        child: CustomTextField(
                          controller: passController,
                          labelString: 'Password',
                          type: ValidateType.password,
                        ),
                      ),
                      SubmitButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              logPrint('no error');

                              // SingInRequested if no form errors
                              context.read<AuthBloc>().add(SingInRequested(
                                  email: emailController.text,
                                  password: passController.text));
                            } else {
                              logPrint('there is an error!!');
                            }
                          },
                          text: 'Sign In'),
                      CustomTextButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(LoadSignUpEvent(
                              emailController.text, passController.text));
                        },
                        text: 'Sign Up',
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text('$loading...'),
                )
              ],
            ),
          );
        }
      },
      listener: (BuildContext context, AuthState state) {
        logPrint('AuthLoginScreen AuthBloc state:${state.runtimeType}');
        if (state is AuthError) {
          FocusManager.instance.primaryFocus?.unfocus();
          logPrint('BlocConsumer AuthError msg:${state.msg}');
          showSnackBar(context, state.msg);
        } else if (state is Authenticated) {
          AutoRouter.of(context).replace(WeatherRoute());
        } else if (state is AuthSignUpLoaded) {
          AutoRouter.of(context).push(
              AuthSignUpRoute(email: state.email, password: state.password));
        }
      },
    ));
  }
}
