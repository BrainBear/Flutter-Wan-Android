import 'package:flutter/material.dart';
import 'package:flutter_wan_android/page/home/home_page.dart';
import 'package:flutter_wan_android/page/profile/profile_page.dart';
import 'package:flutter_wan_android/page/project/project_page.dart';
import 'package:flutter_wan_android/page/structure/structure_page.dart';
import 'package:flutter_wan_android/page/wechat_account/wechat_account_page.dart';

final bottomNavItems = [
  BottomNavItem(Icons.home, "首页"),
  BottomNavItem(Icons.format_list_bulleted, "项目"),
  BottomNavItem(Icons.group_work, "公众号"),
  BottomNavItem(Icons.call_split, "体系"),
  BottomNavItem(Icons.insert_emoticon, "我的"),
];

class BottomNavItem {
  final IconData iconData;
  final String text;

  BottomNavItem(this.iconData, this.text);
}

List<Widget> pages = <Widget>[
  HomePage(),
  ProjectPage(),
  WechatAccountPage(),
  StructurePage(),
  ProfilePage()
];
