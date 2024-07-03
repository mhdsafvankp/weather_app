
import 'package:weather_app/domain/weather/entities/weather_model.dart';

abstract class WeatherLocalRepository{

  // get the saved weather details from cache if available
  WeatherModel? getLastSavedWeather();

  // update the weather details into the cache
  Future<void> cacheWeather(WeatherModel model);

}