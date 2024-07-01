

abstract class AuthEvent{
}

class SingInRequested extends AuthEvent{
  SingInRequested({required this.email, required this.password});
  final String email;
  final String password;
}

class LoadSignInEvent extends AuthEvent{
  final String email;
  final String password;
  LoadSignInEvent(this.email, this.password);
}



class LoadSignUpEvent extends AuthEvent{
  final String email;
  final String password;
  LoadSignUpEvent(this.email, this.password);
}

class SingUpRequested extends AuthEvent{
  SingUpRequested({required this.email, required this.password});
  final String email;
  final String password;
}



class SingOutRequested extends AuthEvent{}
class CheckAuthStatus extends AuthEvent{}



