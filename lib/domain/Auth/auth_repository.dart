
abstract class AuthRepository{
  Future<bool> signInWithEmail(String email, String password);
  Future<void> signOut();
  Future<bool> isSignedIn();
}