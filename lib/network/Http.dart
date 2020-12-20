import 'package:dio/dio.dart';
import 'package:flutter_wan_android/network/http_logs_interceptor.dart';

const WAN_API_BASE_URL = "https://www.wanandroid.com/";
const TIMEOUT_CONNECT = 10 * 1000;
const TIMEOUT_RECEIVE = 10 * 1000;
const TIMEOUT_SEND = 10 * 1000;

class Http {
  Dio _dio;

  static Http _defaultInstance = Http._default();

  factory Http() => _defaultInstance;

  Http._default() {
    BaseOptions options = BaseOptions(
        baseUrl: WAN_API_BASE_URL,
        connectTimeout: TIMEOUT_CONNECT,
        receiveTimeout: TIMEOUT_RECEIVE,
        sendTimeout: TIMEOUT_SEND);

    _dio = new Dio(options);
    _dio.interceptors.add(HttpLogsInterceptor());
  }

  Future<Response<T>> get<T>(String path) {
    return _dio.get(path);
  }

  Future<Response<T>> post<T>(String path) {
    return _dio.post(path);
  }

}


extension DioExt on Response {
  get isSuccessful => statusCode >= 200 && statusCode < 300;
}