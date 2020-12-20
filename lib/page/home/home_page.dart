import 'package:flutter/material.dart';
import 'package:flutter_wan_android/page/home/home_controller.dart';
import 'package:flutter_wan_android/page/home/widgets/article_item_widget.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final HomeController _homeController = Get.put(HomeController());

  final ScrollController _scrollController = ScrollController();

  HomePage({Key key}) : super(key: key) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
       _homeController.loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.separated(
          controller: _scrollController,
          itemBuilder: (context, index) {
            return ArticleItemWidget(article: _homeController.articles[index]);
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 2,
            );
          },
          itemCount: _homeController.articles.length);
    });
  }
}
