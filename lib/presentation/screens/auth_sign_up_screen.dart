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
import '../../domain/common/logger.dart';
import '../../routes/app_router.dart';

@RoutePage()
class AuthSignUpScreen extends StatefulWidget {
  const AuthSignUpScreen({Key? key, required this.email, required this.password})
      : super(key: key);

  final String email;
  final String password;

  @override
  State<AuthSignUpScreen> createState() => _AuthSignUpScreenState();
}

class _AuthSignUpScreenState extends State<AuthSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  void initState() {
    super.initState();

    emailController.text = widget.email;
    passController.text = widget.password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              AutoRouter.of(context).maybePop();
            },
          ),
        ),
        body: BlocConsumer<AuthBloc, AuthState>(
          builder: (BuildContext context, state) {
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
                            'Sign Up',
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
                                context.read<AuthBloc>().add(SingUpRequested(
                                    email: emailController.text,
                                    password: passController.text));
                              } else {
                                logPrint('there is an error!!');
                              }
                            },
                            text: 'Sign Up'),
                        CustomTextButton(
                          onPressed: () {
                            _formKey.currentState?.reset();
                            AutoRouter.of(context).maybePop();
                          },
                          text: 'Login back',
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          listener: (BuildContext context, AuthState state) {
            logPrint('AuthSignUpScreen AuthBloc state:${state.runtimeType}');
            if (state is AuthError) {
              FocusManager.instance.primaryFocus?.unfocus();
              showSnackBar(context, state.msg);
            } else if (state is SignUpCompleted) {
              _formKey.currentState?.reset();
              AutoRouter.of(context).maybePop();
              // sending the sign up details into login screen
              context.read<AuthBloc>().add(LoadSignInEvent(
                  state.email, state.password));
            }
          },
        ));
  }
}
