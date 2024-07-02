import 'dart:io';

import 'package:weather_app/domain/common/app_exceptions.dart';
import 'package:weather_app/domain/weather/weather_model.dart';
import 'package:weather_app/infrastructure/weather/weather_local_data_source.dart';
import 'package:weather_app/infrastructure/weather/weather_remote_data_source.dart';

import '../../domain/weather/weather_remote_repository.dart';

class WeatherRepositoryImpl implements WeatherRemoteRepository {
  WeatherLocalDataSource localDataSource;
  WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl(
      {required this.localDataSource, required this.remoteDataSource});

  @override
  Future<WeatherModel> getCurrentLocationWeather(double lat, double lon) async {
    try {
      final weather = await remoteDataSource.getCurrentLocationWeather(lat, lon);
      await localDataSource.cacheWeather(weather);
      return weather;
    }catch (e){
      final cachedWeather = localDataSource.getLastSavedWeather();
      if(cachedWeather != null){
        return cachedWeather;
      } else {
        if(e is AppException){
          throw AppException(message: e.message);
        } else {
          throw AppException();
        }
      }
    }
  }


  @override
  Future<WeatherModel?> searchWeatherByLocation(String cityName) async {
    try {
      final weather = await remoteDataSource.getWeather(cityName);
      await localDataSource.cacheWeather(weather);
      return weather;
    } on AppException catch(e){
      throw AppException(message: e.message);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<WeatherModel> getLastSavedWeather() async{
    final cachedWeather = localDataSource.getLastSavedWeather();
    if(cachedWeather != null){
      return cachedWeather;
    } else {
      throw AppException();
    }
  }
}
