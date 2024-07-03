

import '../entities/weather_model.dart';

abstract class WeatherRepository{

  /// fetch the weather details from network call using location name
  ///
  /// return [WeatherModel] if success, and cache the details for future.
  /// else return the [AppException]
  Future<WeatherModel?> searchWeatherByLocation(String cityName);


  /// fetch the weather details from network call using current location
  ///
  /// return [WeatherModel] if success, and cache the details for future.
  ///
  /// else will check for recent cached weather is available or not
  ///
  /// if yes, return it, else return the [AppException]
  Future<WeatherModel> getCurrentLocationWeather(double lat, double lon);


  /// return the last saved weather details if available
  Future<WeatherModel> getLastSavedWeather();

}