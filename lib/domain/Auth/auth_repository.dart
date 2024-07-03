
abstract class AuthRepository{


  /// if success return true.
  ///
  /// else return [AppException]
  Future<bool> signInWithEmail(String email, String password);

  /// if success return true.
  ///
  /// else return [AppException]
  Future<bool> signUpWithEmail(String email, String password);

  Future<void> signOut();

  /// return true if login state is available in cache
  bool isLoggedIn();

  /// save the login state into cache
  Future<void> setLoggedIn(bool loggedIn);
}