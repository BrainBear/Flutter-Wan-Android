import 'package:flutter/material.dart';
import 'package:flutter_wan_android/page/home/home_controller.dart';
import 'package:flutter_wan_android/page/home/widgets/article_item_widget.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatelessWidget {
  final HomeController _homeController = Get.put(HomeController());

  final ScrollController _scrollController = ScrollController();

  final RefreshController _refreshController = RefreshController(initialRefresh: true);

  HomePage({Key key}) : super(key: key) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _homeController.loadMore();
      }
    });
  }

  _onRefresh() async {
    await _homeController.refreshData();
    _refreshController.refreshCompleted();
  }


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: false,
        header: MaterialClassicHeader(),
        onRefresh: _onRefresh,
        child: ListView.separated(
            controller: _scrollController,
            itemBuilder: (context, index) {
              return ArticleItemWidget(
                  article: _homeController.articles[index]);
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 2,
              );
            },
            itemCount: _homeController.articles.length),
      );
    });
  }
}
