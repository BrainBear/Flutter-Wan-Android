import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class HttpLogsInterceptor extends InterceptorsWrapper {

  static const TAG = "http_log:";

  @override
  Future onRequest(RequestOptions options) {
    debugPrint("$TAG--> ${options.method} ${options.baseUrl}${options.path}");
    options.headers?.forEach((key, value) {
      debugPrint("$TAG$key: $value");
    });
    debugPrint("$TAG${options.data}");
    debugPrint("$TAG--> END ${options.method}");
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    debugPrint(
        "$TAG<-- ${response.statusCode} ${response.statusMessage} ${response.request.baseUrl}${response.request.path}");
    debugPrint("$TAG${response.data}");
    debugPrint("$TAG<-- END");

    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    debugPrint("$TAG<-- FAILED:$err");
    return super.onError(err);
  }
}
