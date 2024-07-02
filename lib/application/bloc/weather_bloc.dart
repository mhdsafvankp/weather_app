import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/common/app_exceptions.dart';
import 'package:weather_app/presentation/bloc/events/weather_event.dart';
import 'package:weather_app/presentation/bloc/states/weather_state.dart';

import '../../infrastructure/core/debounce.dart';
import '../../infrastructure/location/location_repository_impl.dart';
import '../../infrastructure/weather/weather_repository_impl.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  LocationRepositoryImpl locationRepositoryImpl;
  WeatherRepositoryImpl weatherRepositoryImpl;

  final _preDefinedLocation = [
    'New York',
    'London',
    'Chicago',
    'Houston',
    'Phoenix',
    'Philadelphia',
    'Mumbai',
    'Chennai',
    'TamilNadu',
    'Kerala'
  ];

  WeatherBloc(
      {required this.weatherRepositoryImpl,
      required this.locationRepositoryImpl})
      : super(InitialState()) {
    on<LoadWeatherScreen>(_loadWeatherScreen);
    on<WeatherSearchEvent>(_locationSearchEvent);
    on<LoadPreDefinedLocations>(_loadPreDefindLocation);
    on<SearchedWeatherDetails>(_loadSearchedWeather);
    on<UpdateSearchedWeather>(_updateSearchedWeather);
  }

  _updateSearchedWeather(UpdateSearchedWeather event, Emitter<WeatherState> emit) async {
    if(event.model != null){
      emit(WeatherLoaded(model: event.model!));
    } else {
      try {
        var weather = await weatherRepositoryImpl.getLastSavedWeather();
        emit(WeatherLoaded(model: weather));
      } on AppException catch (e){
        emit(WeatherErrorState(msg: e.toString()));
      } catch (e){
        emit(WeatherErrorState(msg: AppException().message));
      }
    }
  }

  _loadSearchedWeather(SearchedWeatherDetails event, Emitter<WeatherState> emit) async {
    emit(LoaderState());
    if(event.model != null){   // from textFiled
      emit(SearchCompletedState(model: event.model!));
    } else {   // from predefined locations
      try {
        var weather = await weatherRepositoryImpl.searchWeatherByLocation(event.location);
        if(weather != null){
          emit(SearchCompletedState(model: weather ));
        } else {
          emit(LocationSearchErrorState(msg: AppException().message));
        }
      } on  AppException catch(e){
        emit(LocationSearchErrorState(msg: e.message));
      } catch (e){
        emit(LocationSearchErrorState(msg: AppException().message));
      }

    }
  }

  _loadPreDefindLocation(LoadPreDefinedLocations event, Emitter<WeatherState> emit){
    emit(UpdateLocationDetailsState(location: _preDefinedLocation, model: null));
  }

  _locationSearchEvent(WeatherSearchEvent event, Emitter<WeatherState> emit) async {
    emit(LoaderState());
    if(event.query.length > 3){
      try {
        var weather = await weatherRepositoryImpl.searchWeatherByLocation(event.query);
        if(weather != null){
          var locationName = weather.name;
          emit(UpdateLocationDetailsState(location: [locationName], model: weather));
        } else {
          emit(LocationSearchErrorState(msg: AppException().message));
        }
      }on  AppException catch(e){
        emit(LocationSearchErrorState(msg: e.message));
      } catch (e){
        emit(LocationSearchErrorState(msg: AppException().message));
      }
    }
  }

  _loadWeatherScreen(
      LoadWeatherScreen event, Emitter<WeatherState> emit) async {
    emit(LoaderState());
    try {
      var location = await locationRepositoryImpl.determinePosition();
      var weather = await weatherRepositoryImpl.getCurrentLocationWeather(
          location.latitude, location.longitude);
      emit(WeatherLoaded(model: weather));
    } on AppException catch (e){
      emit(WeatherErrorState(msg: e.toString()));
    } catch (e) {
      emit(WeatherErrorState(msg: AppException().message));
    }
  }
}
