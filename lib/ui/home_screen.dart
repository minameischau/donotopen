// import 'package:eatcleanproject/ui/auth/auth_info.dart';
import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';

import 'control_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  @override
  State<HomeScreen> createState() => _HomeScreen();
  const HomeScreen({Key? key}) : super(key: key);
}

class _HomeScreen extends State<HomeScreen> {
  int _currentPage = 0;
  final _pageController = PageController();
  List pages = [];

  @override
  void onTapped(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: const [
          HomePageScreen(),
          ProductsOverviewScreen(),
          CartScreen(),
          AuthProfile()
        ],
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
      ),
      bottomNavigationBar: BottomBar(
        selectedIndex: _currentPage,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() => _currentPage = index);
        },
        items: const <BottomBarItem>[
          BottomBarItem(
            icon: Icon(Icons.home_rounded),
            title: Text('Trang chủ'),
            activeColor: primaryCorlor,
          ),
          BottomBarItem(
            icon: Icon(Icons.store_mall_directory_sharp),
            title: Text('Sản phẩm'),
            activeColor: primaryCorlor,
          ),
          BottomBarItem(
            icon: Icon(
              Icons.shopping_cart,
            ),
            title: Text('Giỏ hàng'),
            activeColor: primaryCorlor,
          ),
          BottomBarItem(
            icon: Icon(Icons.person),
            title: Text('Tài khoản'),
            activeColor: primaryCorlor,
          )
        ],
      ),
    );
  }
}
