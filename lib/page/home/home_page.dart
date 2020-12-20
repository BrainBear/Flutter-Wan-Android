import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_wan_android/page/home/home_controller.dart';
import 'package:flutter_wan_android/page/home/widgets/article_item_widget.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatelessWidget {
  static const BANNER_HEIGHT = 200.0;

  final HomeController _homeController = Get.put(HomeController());

  final ScrollController _scrollController = ScrollController();

  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  HomePage({Key key}) : super(key: key) {
    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        _homeController.loadMore();
      }

      if (_scrollController.offset >= BANNER_HEIGHT) {
        _homeController.appBarTitleVisible = true;
      } else if (_scrollController.offset < BANNER_HEIGHT) {
        _homeController.appBarTitleVisible = false;
      }
    });
  }

  _onRefresh() async {
    await _homeController.refreshData();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: false,
      header: MaterialClassicHeader(),
      onRefresh: _onRefresh,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _buildAppBar(),
          _buildArticleList(),
        ],
      ),
    );
    // });
  }

  _buildArticleList() {
    return Obx(
      () {
        return SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return ArticleItemWidget(article: _homeController.articles[index]);
        }, childCount: _homeController.articles.length));
      },
    );
  }

  _buildAppBar() {
    return SliverAppBar(
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: _buildAppBarTitle(),
        background: _buildBanner(),
        centerTitle: true,
      ),
      expandedHeight: BANNER_HEIGHT,
    );
  }

  _buildAppBarTitle() {
    return Obx(() {
      if (_homeController.showAppBarTitle.value) {
        return Text("Wan");
      } else {
        return SizedBox.shrink();
      }
    });
  }

  _buildBanner() {
    return Obx(() {
      return Swiper(
        loop: true,
        autoplay: true,
        autoplayDelay: 5000,
        pagination: SwiperPagination(),
        itemCount: _homeController.banners.length,
        itemBuilder: (ctx, index) {
          return CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: _homeController.banners[index].imagePath);
        },
      );
    });
  }
}
