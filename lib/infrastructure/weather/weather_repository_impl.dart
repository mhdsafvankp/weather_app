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
        throw Exception('Failed to load weather');
      }
    }
  }

  @override
  Future<WeatherModel> getWeather(String cityName) async{
    try {
      final weather = await remoteDataSource.getWeather(cityName);
      await localDataSource.cacheWeather(weather);
      return weather;
    }catch (e){
      final cachedWeather = localDataSource.getLastSavedWeather();
      if(cachedWeather != null){
        return cachedWeather;
      } else {
        throw Exception('Failed to load weather');
      }
    }
  }
}
