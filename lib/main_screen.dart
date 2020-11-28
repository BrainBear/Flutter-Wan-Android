import 'package:flutter/material.dart';
import 'package:flutter_wan_android/page/page_data.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  var _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (ctx, index) => pages[index],
        itemCount: pages.length,
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        items: _buildBottomNavigationItems(),
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavigationItems() {
    return bottomNavItems
        .map((e) =>
            BottomNavigationBarItem(icon: Icon(e.iconData), label: e.text))
        .toList();
  }
}
