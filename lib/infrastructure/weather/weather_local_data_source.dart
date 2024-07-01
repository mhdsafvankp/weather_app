import 'package:weather_app/domain/common/logger.dart';
import 'package:weather_app/domain/weather/weather_local_repository.dart';
import 'package:weather_app/domain/weather/weather_model.dart';
import '../core/hive_service.dart';

class WeatherLocalDataSource implements WeatherLocalRepository {
  final weatherHiveKey = 'current_weather';

  final HiveService<WeatherModel> hiveService;

  WeatherLocalDataSource({required this.hiveService});

  @override
  Future<void> cacheWeather(WeatherModel model) async {
    await hiveService.saveData(weatherHiveKey, model);
  }

  @override
  WeatherModel? getLastSavedWeather() {
    return hiveService.getData(weatherHiveKey);
  }
}
