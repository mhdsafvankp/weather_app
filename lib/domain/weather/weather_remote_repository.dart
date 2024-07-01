
import 'package:weather_app/domain/weather/weather_model.dart';

abstract class WeatherRemoteRepository{

  Future<WeatherModel> getWeather(String cityName);
  Future<WeatherModel> getCurrentLocationWeather(double lat, double lon);

}