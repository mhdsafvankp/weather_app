import 'package:weather_app/domain/weather/weather_model.dart';
import '../../domain/common/api.dart';
import '../../domain/weather/weather_repository.dart';
import '../core/dio_api_client.dart';

class WeatherRemoteDataSource implements WeatherRepository {

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
    } else if(response.statusCode == 404){
      throw Exception("city not found");
    }else {
      throw Exception('Failed to load weather');
    }
  }
}
