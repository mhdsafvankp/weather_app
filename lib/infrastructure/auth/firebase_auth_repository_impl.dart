import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_app/domain/Auth/auth_exceptions.dart';
import 'package:weather_app/domain/Auth/auth_repository.dart';
import 'package:weather_app/domain/common/app_exceptions.dart';
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
      UserCredential credential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return (credential.user != null);
    } on FirebaseAuthException catch (e) {
      throw AuthenticationException.fromCode(e.code);
    } on SocketException{
      throw AppSocketException();
    } catch (e) {
      throw AppException();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw AuthenticationException.fromCode(e.code);
    } on SocketException{
      throw AppSocketException();
    } catch (e) {
      throw AppException();
    }

  }

  @override
  Future<bool> signUpWithEmail(String email, String password) async {
    try {
      UserCredential credential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return (credential.user != null);
    } on FirebaseAuthException catch (e) {
      throw AuthenticationException.fromCode(e.code);
    } on SocketException{
      throw AppSocketException();
    } catch (e) {
      throw AppException();
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
