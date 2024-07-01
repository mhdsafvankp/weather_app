

abstract class AuthState {}

class AuthInitial extends AuthState{}
class AuthLoading extends AuthState{}
class AuthSignUpLoaded extends AuthState{
  final String email;
  final String password;
  AuthSignUpLoaded({required this.email, required this.password});
}
class AuthSignInLoaded extends AuthState{
  final String email;
  final String password;
  AuthSignInLoaded({required this.email, required this.password});
}
class SignUpCompleted extends AuthState{
  final String email;
  final String password;
  SignUpCompleted({required this.email, required this.password});
}

class Authenticated extends AuthState{}
class UnAuthenticated extends AuthState{}
class AuthError extends AuthState{
  final String msg;
  AuthError({required this.msg});
}
