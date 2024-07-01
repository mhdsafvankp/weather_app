

import 'package:weather_app/domain/weather/weather_local_repository.dart';
import 'package:weather_app/domain/weather/weather_model.dart';

class WeatherLocalDataSource implements WeatherLocalRepository{
  @override
  Future<void> cacheWeather(WeatherModel model) {
    // TODO: implement cacheWeather
    throw UnimplementedError();
  }

  @override
  Future<WeatherModel?> getLastSavedWeather() {
    // TODO: implement getLastSavedWeather
    throw UnimplementedError();
  }

}