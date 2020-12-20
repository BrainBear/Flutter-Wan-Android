import 'package:flutter/cupertino.dart';
import 'package:flutter_wan_android/data/model/result.dart';
import 'package:flutter_wan_android/data/model/wan_api_response.dart';
import 'package:flutter_wan_android/network/Http.dart';
import 'package:flutter_wan_android/network/http_exception.dart';

import 'model/article.dart';

class WanRemoteDataSource {
  final http = Http();

  Future<Result<List<Article>>> fetchTopArticles() async {
    try {
      var response = await http.get('article/top/json');
      if (response.isSuccessful) {
        var wanApiResponse = WanApiResponse.fromJson(response.data);

        if (!wanApiResponse.success) {
          throw WanApiException.fromResponse(wanApiResponse);
        }

        return Result.success(wanApiResponse.data
            .map<Article>((item) => Article.fromJson(item))
            .toList());
      } else {
        throw HttpException(response.statusCode, response.statusMessage,
            response.request.uri.toString());
      }
    } catch (e) {
      return Result.error(e);
    }
  }
}
