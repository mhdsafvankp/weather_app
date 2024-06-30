import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_app/domain/Auth/auth_repository.dart';

class FirebaseAuthRepositoryImpl implements AuthRepository {

  final FirebaseAuth firebaseAuth;

  FirebaseAuthRepositoryImpl({required this.firebaseAuth});


  @override
  Future<bool> isSignedIn() async{
    final user = firebaseAuth.currentUser;
    return user != null;
  }

  @override
  Future<bool> signInWithEmail(String email, String password) async{
    try{
      UserCredential credential = await firebaseAuth.
      signInWithEmailAndPassword(email: email, password: password);
      return (credential.user != null);
    }catch (e){
      rethrow;
    }
  }

  @override
  Future<void> signOut() async  {
    await firebaseAuth.signOut();
  }
}
