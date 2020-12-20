import 'package:flutter/material.dart';
import 'package:flutter_wan_android/page/home/home_controller.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {

  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.separated(
          itemBuilder: (context, index) {
            return Text(_homeController.articles[index].title);
          }, separatorBuilder: (context, index) {
        return SizedBox(height: 2,);
      }, itemCount: _homeController.articles.length);
    });
  }
}
