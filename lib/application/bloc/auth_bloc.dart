import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/bloc/events/auth_event.dart';
import 'package:weather_app/presentation/bloc/states/auth_state.dart';

import '../../infrastructure/auth/firebase_auth_repository_impl.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuthRepositoryImpl firebaseAuthRepositoryImpl;

  AuthBloc({required this.firebaseAuthRepositoryImpl}) : super(AuthInitial()) {
    on<SingInRequested>(signInRequestHandler);
    on<SingOutRequested>(signOutRequestHandler);
    on<CheckAuthStatus>(checkAuthRequestHandler);
  }

  checkAuthRequestHandler(
      CheckAuthStatus event, Emitter<AuthState> emit) async {
    var isSign = await firebaseAuthRepositoryImpl.isSignedIn();
    isSign ? Authenticated() : emit(UnAuthenticated());
  }

  signOutRequestHandler(SingOutRequested event, Emitter<AuthState> emit) async {
    await firebaseAuthRepositoryImpl.signOut();
    emit(UnAuthenticated());
  }

  signInRequestHandler(SingInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      var isSign = await firebaseAuthRepositoryImpl.signInWithEmail(
          event.email, event.password);

      isSign ? emit(Authenticated()) : emit(AuthError(msg: 'Login Error'));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(msg: e.message ?? 'Login Error'));
    }
  }
}
