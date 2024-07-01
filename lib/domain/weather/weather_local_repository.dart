
import 'package:weather_app/domain/weather/weather_model.dart';

abstract class WeatherLocalRepository{

  WeatherModel? getLastSavedWeather();
  Future<void> cacheWeather(WeatherModel model);

}