import 'package:dio/dio.dart';
import 'package:weather_app/domain/common/app_exceptions.dart';
import 'package:weather_app/domain/common/logger.dart';
import 'package:weather_app/domain/weather/entities/weather_model.dart';
import 'package:weather_app/domain/weather/repos/weather_remote_repository.dart';
import '../../domain/common/api.dart';
import '../core/dio_api_client.dart';

class WeatherRemoteDataSource implements WeatherRemoteRepository {
  DioApiClient client;

  WeatherRemoteDataSource({required this.client});

  @override
  Future<WeatherModel> getCurrentLocationWeather(double lat, double lon) async {
    try {
      var response = await client.getCall(
          url: weatherApiUrl,
          queryParameters: {'lat': lat, "lon": lon, "appid": apiKey});
      return _returnResponse(response);
    } on AppException catch (e) {
      throw AppException(message: e.message);
    } catch (e) {
      throw AppException();
    }
  }

  @override
  Future<WeatherModel> getWeather(String cityName) async {
    try {
      var response = await client.getCall(
          url: weatherApiUrl,
          queryParameters: {'q': cityName, "appid": apiKey});
      return _returnResponse(response);
    } on AppException catch (e) {
      throw AppException(message: e.message);
    } catch (e) {
      throw AppException();
    }
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = WeatherModel.fromJson(response.data);
        return responseJson;
      case 400:
        throw BadRequestException(suffix: response.statusMessage.toString());
      case 401:
      case 403:
        throw UnauthorisedException(suffix: response.statusMessage.toString());
      case 404:
        throw AppException(message: "city not found");
      case 500:
      default:
        throw FetchDataException();
    }
  }
}
