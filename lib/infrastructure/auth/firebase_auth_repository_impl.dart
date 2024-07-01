import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_app/domain/Auth/auth_repository.dart';
import 'package:weather_app/domain/common/logger.dart';

import '../core/hive_service.dart';

class FirebaseAuthRepositoryImpl implements AuthRepository {

  final authHiveKey = 'loggedIn';
  final FirebaseAuth firebaseAuth;
  final HiveService<bool> hiveService;

  FirebaseAuthRepositoryImpl({required this.firebaseAuth, required this.hiveService});


  @override
  Future<bool> signInWithEmail(String email, String password) async {
    try {
      UserCredential credential = await firebaseAuth.
      signInWithEmailAndPassword(email: email, password: password);
      return (credential.user != null);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<bool> signUpWithEmail(String email, String password) async {
    try {
      UserCredential credential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return (credential.user != null);
    } catch (e) {
      rethrow;
    }
  }

  @override
  bool isLoggedIn() {
    logPrint('isLoggedIn called with ${hiveService.getData(authHiveKey)}');
    return hiveService.getData(authHiveKey) ?? false;
  }


  @override
  Future<void> setLoggedIn(bool loggedIn) async{
    logPrint('setLoggedIn called with $loggedIn');
    await hiveService.saveData(authHiveKey, loggedIn);
  }
}
