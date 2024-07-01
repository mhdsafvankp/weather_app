import 'package:dio/dio.dart';
import 'package:weather_app/domain/common/logger.dart';

class DioApiClient {
  final Dio dio;

  DioApiClient({required this.dio});

  Future<Response> getCall({required String url, Map<String, dynamic>? queryParameters}) async{

    logPrint('============= REQUEST START ===========');
    logPrint('Type: getCall');
    logPrint('url: $url');
    logPrint('queryParameters: $queryParameters');
    logPrint('============= REQUEST END ===========');

    var response = await dio.get(url, queryParameters: queryParameters);

    logPrint('============= RESPONSE START ===========');
    logPrint('Type: getCall');
    logPrint('data : ${response.data}');
    logPrint('statusCode: ${response.statusCode}');
    logPrint('statusMessage: ${response.statusMessage}');
    logPrint('============= RESPONSE END ===========');

    return response;

  }
}
