
import 'package:weather_app/domain/weather/weather_model.dart';

abstract class WeatherLocalRepository{

  Future<WeatherModel?> getLastSavedWeather();
  Future<void> cacheWeather(WeatherModel model);

}