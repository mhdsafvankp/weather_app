import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/Auth/auth_exceptions.dart';
import 'package:weather_app/domain/common/app_exceptions.dart';
import 'package:weather_app/presentation/bloc/events/auth_event.dart';
import 'package:weather_app/presentation/bloc/states/auth_state.dart';

import '../../infrastructure/auth/firebase_auth_repository_impl.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuthRepositoryImpl firebaseAuthRepositoryImpl;

  AuthBloc({required this.firebaseAuthRepositoryImpl}) : super(AuthInitial()) {
    on<SingInRequested>(_signInRequestHandler);
    on<SingUpRequested>(_signUpRequestHandler);
    on<SingOutRequested>(_signOutRequestHandler);
    on<CheckAuthStatus>(_checkAuthRequestHandler);
    on<LoadSignUpEvent>(_loadSignUpRequestHandler);
    on<LoadSignInEvent>(_loadSignInRequestHandler);
  }

  _loadSignInRequestHandler(
      LoadSignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthSignInLoaded(email: event.email, password: event.password));
  }

  _loadSignUpRequestHandler(
      LoadSignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthSignUpLoaded(email: event.email, password: event.password));
  }

  _checkAuthRequestHandler(
      CheckAuthStatus event, Emitter<AuthState> emit) async {
    var isSign = firebaseAuthRepositoryImpl.isLoggedIn();
    isSign ? emit(Authenticated()) : emit(UnAuthenticated());
  }

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
