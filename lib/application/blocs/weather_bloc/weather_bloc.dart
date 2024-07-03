import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/common/app_exceptions.dart';
import 'package:weather_app/application/blocs/weather_bloc/weather_event.dart';
import 'package:weather_app/application/blocs/weather_bloc/weather_state.dart';

import '../../../infrastructure/location/location_repository_impl.dart';
import '../../../infrastructure/weather/weather_repository_impl.dart';


/// [locationRepositoryImpl] - geoLocation details can fetch
/// [weatherRepositoryImpl] - fetch weather details locally or network
/// if any error from network weather, then check for local weather available.
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  LocationRepositoryImpl locationRepositoryImpl;
  WeatherRepositoryImpl weatherRepositoryImpl;

  /// DefinedLocations
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

  /// Updating the UI with received weather details.
  ///
  /// emit the [WeatherLoaded] state if weather details available
  ///
  /// if weather details not available , will check for any cache weather
  /// available or not
  ///
  /// if cache also not available, will emit the [WeatherErrorState] state with
  /// error message
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

  /// Update the search location screen with searched weather details
  ///
  /// if chosen the searched location, Both [weather] and [location] name available.
  ///
  /// if chosen the pre defined location, [location] name only available,
  /// so will call the [searchWeatherByLocation] to get the weather details from
  /// here.
  ///
  /// And in both cases, emit [SearchCompletedState] state into search screen.
  /// Here it will pop the srech screen and sending back the weather details to
  /// Weather display sceen
  ///
  ///
  /// if any error [LocationSearchErrorState] state with error message
  /// will emit to the search screen
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

  /// Here Just pre-filling the DefinedLocations
  /// emit the [UpdateLocationDetailsState] with list
  _loadPreDefindLocation(LoadPreDefinedLocations event, Emitter<WeatherState> emit){
    emit(UpdateLocationDetailsState(location: _preDefinedLocation, model: null));
  }


  /// Updating the UI with weather details from searched location
  ///
  /// [searchWeatherByLocation] - fetching weather from the searched location
  ///
  /// if all good, emit the [UpdateLocationDetailsState] state with [weather]
  /// details and [location] Name, This Name will show in the search List
  /// else will emit the [LocationSearchErrorState] state with error message
  _locationSearchEvent(WeatherSearchEvent event, Emitter<WeatherState> emit) async {

    if(event.query.length > 3){
      emit(LoaderState());
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


  /// Updating the UI with weather details
  ///
  /// [determinePosition] - fetching the current location
  ///
  /// [getCurrentLocationWeather] - fetching weather from the current location
  ///
  /// if all good, emit the [WeatherLoaded] state with weather details for UI
  ///
  /// else will emit the [WeatherErrorState] state with error message
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
      try {
        var weather = await weatherRepositoryImpl.getLastSavedWeather();
        emit(WeatherLoaded(model: weather));
      } on AppException catch (e){
        emit(WeatherErrorState(msg: e.toString()));
      }catch (e){
        emit(WeatherErrorState(msg: AppException().message));
      }
    }
  }
}
