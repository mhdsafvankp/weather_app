import 'dart:io';

import 'package:dio/dio.dart';
import 'package:weather_app/domain/common/app_exceptions.dart';
import 'package:weather_app/domain/common/logger.dart';


///  DioClient
///
/// [getCall] - for making the GET request with queryParameters
///
/// if success, return the response,
/// else [AppException]
class DioApiClient {
  final Dio dio;

  DioApiClient({required this.dio});

  Future<Response> getCall({required String url, Map<String, dynamic>? queryParameters}) async{

    try {
      logPrint('============= REQUEST START ===========');
      logPrint('Type: getCall');
      logPrint('url: $url');
      logPrint('queryParameters: $queryParameters');
      logPrint('============= REQUEST END ===========');

      var response = await dio.get(url, queryParameters: queryParameters,
          options: Options(validateStatus: (value) {
        return true;   // will validate request codes separately
      }));

      logPrint('============= RESPONSE START ===========');
      logPrint('Type: getCall');
      logPrint('data : ${response.data}');
      logPrint('statusCode: ${response.statusCode}');
      logPrint('statusMessage: ${response.statusMessage}');
      logPrint('============= RESPONSE END ===========');

      return response;
    } on SocketException {
      throw AppSocketException();
    } on DioException catch(e){
      if(e.type == DioExceptionType.connectionError) {
        throw AppSocketException();
      } else {
        throw AppException();
      }
    } catch (e){
      throw AppException();
    }


  }
}
