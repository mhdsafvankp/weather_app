
import 'package:weather_app/domain/weather/weather_model.dart';

abstract class WeatherRepository{

  Future<WeatherModel> getWeather(String cityName);
  Future<WeatherModel> getCurrentLocationWeather(double lat, double lon);

}