
import 'package:weather_app/domain/weather/weather_model.dart';

abstract class WeatherRemoteRepository{

  Future<WeatherModel?> searchWeatherByLocation(String cityName);
  Future<WeatherModel> getCurrentLocationWeather(double lat, double lon);
  Future<WeatherModel> getLastSavedWeather();

}