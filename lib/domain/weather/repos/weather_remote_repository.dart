import 'package:weather_app/domain/weather/entities/weather_model.dart';

abstract class WeatherRemoteRepository{

  /// get weather details from network call using location name
  ///
  /// if any exception will throw [AppException]
  Future<WeatherModel> getWeather(String cityName);

  /// get weather details from network call using current location
  ///
  /// if any exception will throw [AppException]
  Future<WeatherModel> getCurrentLocationWeather(double lat, double lon);

}