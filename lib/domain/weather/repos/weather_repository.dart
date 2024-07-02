
import 'package:weather_app/domain/weather/entities/weather_model.dart';

abstract class WeatherRepository{

  Future<WeatherModel> getWeather(String cityName);
  Future<WeatherModel> getCurrentLocationWeather(double lat, double lon);

}