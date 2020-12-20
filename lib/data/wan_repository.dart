import 'package:flutter_wan_android/data/model/article.dart';
import 'package:flutter_wan_android/data/wan_remote_data_source.dart';

import 'model/result.dart';

class WanRepository {
  var _removeDataSource = WanRemoteDataSource();



  Future<Result<List<Article>>> fetchTopArticles() {
    return _removeDataSource.fetchTopArticles();
  }
}
