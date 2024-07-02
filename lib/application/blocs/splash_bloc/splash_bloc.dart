import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/application/blocs/splash_bloc/splash_event.dart';
import 'package:weather_app/application/blocs/splash_bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(InitialSplash()) {
    on<LoadSplashScreen>(_loadedSplashScreen);
  }

  _loadedSplashScreen(LoadSplashScreen event, Emitter<SplashState> emit) async {
    // Simulate a delay for the splash screen
    await Future.delayed(const Duration(seconds: 1));
    emit(LoadedSplash());
  }
}
