import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/bloc/events/weather_event.dart';
import 'package:weather_app/presentation/bloc/states/weather_state.dart';

import '../../infrastructure/location/location_repository_impl.dart';
import '../../infrastructure/weather/weather_repository_impl.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(
      {required this.weatherRepositoryImpl,
      required this.locationRepositoryImpl})
      : super(InitialState()) {
    on<LoadWeatherScreen>(_loadWeatherScreen);
  }

  LocationRepositoryImpl locationRepositoryImpl;
  WeatherRepositoryImpl weatherRepositoryImpl;

  _loadWeatherScreen(
      LoadWeatherScreen event, Emitter<WeatherState> emit) async {
    emit(LoaderState());
    try {
      var location = await locationRepositoryImpl.determinePosition();
      var weather = await weatherRepositoryImpl.getCurrentLocationWeather(
          location.latitude, location.longitude);
      emit(WeatherLoaded(model: weather));
    } on Exception catch (e) {
      // TODO: need to Handle
      emit(WeatherErrorState(msg: e.toString()));
    }
  }
}
