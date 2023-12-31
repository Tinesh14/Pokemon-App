import 'package:dio/dio.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class IDioService {
  Dio getDio();
}

class DioService implements IDioService {
  // var _prettyDioLogger = PrettyDioLogger(
  //   requestHeader: true,
  //   // requestBody: true,
  //   // responseBody: true,
  //   responseHeader: false,
  //   error: true,
  //   compact: true,
  //   maxWidth: 90,
  // );
  @override
  Dio getDio() {
    var dio = Dio(
      BaseOptions(
        baseUrl: 'https://pokeapi.co/api/v2/',
      ),
    );
    // dio.interceptors.add(_prettyDioLogger);
    return dio;
  }
}
