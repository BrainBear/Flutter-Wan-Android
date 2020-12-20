import 'package:flutter_wan_android/data/model/article.dart';
import 'package:flutter_wan_android/data/wan_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var articles = List<Article>().obs;

  final wanRepository = WanRepository();

  @override
  void onInit() {
    super.onInit();
    _refresh();
  }


  _refresh() async{
    var futureTopArticles = wanRepository.fetchTopArticles();
    var futureFirstPageArticles = wanRepository.fetchArticles(0);

    var results = await Future.wait([futureTopArticles, futureFirstPageArticles]);

    var list = List<Article>();
    if(results[0].isSuccessful && results[1].isSuccessful) {
      list.addAll(results[0].data);
      list.addAll(results[1].data);
    }
    articles.assignAll(list);
  }
}
