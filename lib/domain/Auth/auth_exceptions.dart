import 'package:weather_app/domain/common/logger.dart';

String getMessageFromErrorCode(String errorCode) {
  logPrint('Firebase Esxception $errorCode');
  switch (errorCode) {
    case "email-already-in-use":
      return "Email already used. Go to login page.";
    case "invalid-credential":
      return "Credential is incorrect";
    case "network-request-failed":
      return "No Internet connection";
    default:
      return "Login failed. Please try again.";
  }
}

class AuthenticationException implements Exception {
  const AuthenticationException(
      {this.message = "Login failed. Please try again"});

  final String message;

  factory AuthenticationException.fromCode(String code) {
    var msg = getMessageFromErrorCode(code);
    return AuthenticationException(message: msg);
  }
}
