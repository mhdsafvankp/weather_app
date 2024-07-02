
abstract class AuthRepository{
  Future<bool> signInWithEmail(String email, String password);
  Future<bool> signUpWithEmail(String email, String password);
  Future<void> signOut();
  bool isLoggedIn();
  Future<void> setLoggedIn(bool loggedIn);
}