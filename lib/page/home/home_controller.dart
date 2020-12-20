import 'package:flutter/material.dart';
import 'package:flutter_wan_android/data/model/article.dart';
import 'package:flutter_wan_android/data/model/banner.dart';
import 'package:flutter_wan_android/data/wan_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var articles = List<Article>().obs;
  var banners = List<BannerModel>().obs;
  var showAppBarTitle = false.obs;

  final wanRepository = WanRepository();

  var _loading = false;
  var _pageNum = 1;

  set appBarTitleVisible(bool visible) {
    showAppBarTitle.value = visible;
  }

  Future<Null> refreshData() async {
    await _refresh();
  }

  _refresh() async {
    if (_loading) return;
    _loading = true;
    var futureTopArticles = wanRepository.fetchTopArticles();
    var futureFirstPageArticles = wanRepository.fetchArticles(0);

    var results =
        await Future.wait([futureTopArticles, futureFirstPageArticles]);

    var list = List<Article>();
    if (results[0].isSuccessful && results[1].isSuccessful) {
      list.addAll(results[0].data);
      list.addAll(results[1].data);
    }
    articles.assignAll(list);
    _loading = false;
    _pageNum = 1;

    var futureBanner = wanRepository.fetchBanner();

    var bannerResult = await futureBanner;
    if (bannerResult.isSuccessful) {
      banners.assignAll(bannerResult.data);
    }
  }

  void loadMore() {
    if (_loading) return;
    _loading = true;

    wanRepository.fetchArticles(_pageNum).then((value) {
      if (value.isSuccessful) {
        articles.addAll(value.data);
      }
      _pageNum++;
      _loading = false;
    });
  }
}
