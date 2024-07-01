import 'package:weather_app/domain/weather/weather_model.dart';
import 'package:weather_app/domain/weather/weather_remote_repository.dart';

import '../../domain/common/api.dart';
import '../core/weather_api_client.dart';

class WeatherRemoteDataSource implements WeatherRemoteRepository {

  DioApiClient client;
  WeatherRemoteDataSource({required this.client});


  @override
  Future<WeatherModel> getCurrentLocationWeather(double lat, double lon) async{
    var response = await client.getCall(url: weatherApiUrl , queryParameters: {
      'lat': lat,
      "lon" : lon,
      "appid" : apiKey
    });

    if(response.statusCode == 200){
      return WeatherModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load weather');
    }

  }

  @override
  Future<WeatherModel> getWeather(String cityName) async {
    var response = await client.getCall(url: weatherApiUrl , queryParameters: {
      'q': cityName,
      "appid" : apiKey
    });

    if(response.statusCode == 200){
      return WeatherModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
