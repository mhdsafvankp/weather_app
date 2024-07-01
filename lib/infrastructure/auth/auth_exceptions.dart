

class LogInWithEmailAndPasswordFailure implements Exception {
  const LogInWithEmailAndPasswordFailure([
    this.message = 'Unable to Login. Please try later',
  ]);

  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-credential':
        return const LogInWithEmailAndPasswordFailure(
          'Credentials is not found, please create an account',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }

  final String message;
}