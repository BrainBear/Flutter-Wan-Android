import 'package:flutter_wan_android/data/model/article.dart';
import 'package:flutter_wan_android/data/wan_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var articles = List<Article>().obs;

  final wanRepository = WanRepository();

  @override
  void onInit() {
    super.onInit();
    wanRepository.fetchTopArticles().then((value) {
      if (value.isSuccessful) {
        articles.addAll(value.data);
      }
    });
  }
}
