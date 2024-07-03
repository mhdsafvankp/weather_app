import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/Auth/auth_exceptions.dart';
import 'package:weather_app/domain/common/app_exceptions.dart';
import 'package:weather_app/application/blocs/auth_bloc/auth_event.dart';
import 'package:weather_app/application/blocs/auth_bloc/auth_state.dart';

import '../../../infrastructure/auth/firebase_auth_repository_impl.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuthRepositoryImpl firebaseAuthRepositoryImpl;

  AuthBloc({required this.firebaseAuthRepositoryImpl}) : super(AuthInitial()) {
    on<SingInRequested>(_signInRequestHandler);
    on<SingUpRequested>(_signUpRequestHandler);
    on<SingOutRequested>(_signOutRequestHandler);
    on<CheckAuthStatus>(_checkAuthRequestHandler);
    on<LoadSignUpEvent>(_loadSignUpRequestHandler);
  }


  /// It handles the SignUp navigation from SignIn screen.
  ///
  /// it can send the sign In details into signUp screen for
  /// prefill the data for [email] and [password]
  _loadSignUpRequestHandler(
      LoadSignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthSignUpLoaded(email: event.email, password: event.password));
  }

  /// It checks the Current Authentication status
  /// from the local cache [isLoggedIn]
  /// emit [Authenticated] state if its true
  /// else emit [UnAuthenticated] if its false
  _checkAuthRequestHandler(
      CheckAuthStatus event, Emitter<AuthState> emit) async {
    var isSign = firebaseAuthRepositoryImpl.isLoggedIn();
    isSign ? emit(Authenticated()) : emit(UnAuthenticated());
  }

  /// firebase signOut request handler
  /// emit [UnAuthenticated] state if success
  /// else emit [AuthSignUpError] state with error message
  /// [setLoggedIn] function will save the login state in Locally [false]
  _signOutRequestHandler(
      SingOutRequested event, Emitter<AuthState> emit) async {
    try {
      await firebaseAuthRepositoryImpl.signOut();

      // saving sign-in preference
      firebaseAuthRepositoryImpl.setLoggedIn(false);
      emit(UnAuthenticated());
    } on AuthenticationException catch (e) {
      emit(AuthSignUpError(msg: e.message));
    } on AppException catch(e){
      emit(AuthSignUpError(msg: e.message));
    } catch (e) {
      emit(AuthSignUpError(msg: AppException().message));
    }

  }

  /// firebase signIn request handler
  /// emit [Authenticated] state if success
  /// else emit [AuthLoginInError] state with error message
  /// [setLoggedIn] function will save the login state in Locally [true]
  _signInRequestHandler(SingInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      var isSign = await firebaseAuthRepositoryImpl.signInWithEmail(
          event.email, event.password);

      // saving sign-in preference
      firebaseAuthRepositoryImpl.setLoggedIn(isSign);

      isSign ? emit(Authenticated()) : emit(AuthLoginInError(msg: 'Login Error'));
    } on AuthenticationException catch (e) {
      emit(AuthLoginInError(msg: e.message));
    } on AppException catch(e){
      emit(AuthLoginInError(msg: e.message));
    } catch (e) {
      emit(AuthLoginInError(msg: AppException().message));
    }
  }


  /// firebase signUp request handler
  /// emit [SignUpCompleted] state if success
  /// else emit [AuthSignUpError] state with error message
  _signUpRequestHandler(SingUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      var isSign = await firebaseAuthRepositoryImpl.signUpWithEmail(
          event.email, event.password);

      isSign
          ? emit(SignUpCompleted(email: event.email, password: event.password))
          : emit(AuthSignUpError(msg: 'Login Error'));
    } on AuthenticationException catch (e) {
      emit(AuthSignUpError(msg: e.message));
    } on AppException catch(e){
      emit(AuthSignUpError(msg: e.message));
    } catch (e) {
      emit(AuthSignUpError(msg: AppException().message));
    }
  }
}
