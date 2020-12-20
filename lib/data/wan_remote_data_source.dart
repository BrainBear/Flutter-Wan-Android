import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android/data/model/article_page.dart';
import 'package:flutter_wan_android/data/model/result.dart';
import 'package:flutter_wan_android/data/model/wan_api_response.dart';
import 'package:flutter_wan_android/network/Http.dart';
import 'package:flutter_wan_android/network/http_exception.dart';

import 'model/article.dart';

class WanRemoteDataSource {
  final http = Http();

  Future<Result<List<Article>>> fetchTopArticles() async {
    return safeJsonListApiCall(
        () => http.get('article/top/json'), (json) => Article.fromJson(json));
  }

  Future<Result<ArticlePage>> fetchArticles(int page) async {
    return safeJsonApiCall(() => http.get('article/list/$page/json'),
        (json) => ArticlePage.fromJson(json));
  }
}

typedef JSONApiCall = Future<Response> Function();

typedef JSONMapConverter<T> = T Function(dynamic json);

Future<Result<List<T>>> safeJsonListApiCall<T>(
    JSONApiCall jsonApiCall, JSONMapConverter<T> dataConverter) async {
  try {
    var response = await jsonApiCall();
    if (response.isSuccessful) {
      var wanApiResponse = WanApiResponse.fromJson(response.data);

      if (!wanApiResponse.success) {
        throw WanApiException.fromResponse(wanApiResponse);
      }

      return Result.success(wanApiResponse.data.map<T>(dataConverter).toList());
    } else {
      throw HttpException(response.statusCode, response.statusMessage,
          response.request.uri.toString());
    }
  } catch (e) {
    return Result.error(e);
  }
}



Future<Result<T>> safeJsonApiCall<T>(
    JSONApiCall jsonApiCall, JSONMapConverter<T> dataConverter) async {
  try {
    var response = await jsonApiCall();
    if (response.isSuccessful) {
      var wanApiResponse = WanApiResponse.fromJson(response.data);

      if (!wanApiResponse.success) {
        throw WanApiException.fromResponse(wanApiResponse);
      }

      return Result.success(dataConverter(wanApiResponse.data));
    } else {
      throw HttpException(response.statusCode, response.statusMessage,
          response.request.uri.toString());
    }
  } catch (e) {
    return Result.error(e);
  }
}
