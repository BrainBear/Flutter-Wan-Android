import 'package:flutter_wan_android/data/model/article.dart';
import 'package:flutter_wan_android/data/wan_remote_data_source.dart';

import 'model/banner.dart';
import 'model/result.dart';

class WanRepository {
  var _removeDataSource = WanRemoteDataSource();



  Future<Result<List<Article>>> fetchTopArticles() {
    return _removeDataSource.fetchTopArticles();
  }

  Future<Result<List<Article>>> fetchArticles(int page) async {
    var result = await _removeDataSource.fetchArticles(page);

    if(result.isSuccessful) {
      return Future.value(Result.success(result.data.datas));
    }else{
      return Future.value(Result.error(result.error));
    }
  }

  Future<Result<List<BannerModel>>> fetchBanner() {
    return _removeDataSource.fetchBanner();
  }
}
