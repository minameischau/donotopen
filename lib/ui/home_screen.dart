import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';

import 'package:panow/ui/control_screen.dart';

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

  // @override
  // void onTapped(int index) {
  //   setState(() {
  //     _currentPage = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          HomePageScreen(),
          ProductsOverviewScreen(),
          CartScreen(),
          AuthProfile(),
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
            title: Text(
              'Home',
              style: TextStyle(
                  fontFamily: 'SFCompactRounded', fontWeight: FontWeight.bold),
            ),
            activeColor: primaryCorlor,
          ),
          BottomBarItem(
            icon: Icon(Icons.store_mall_directory_rounded),
            title: Text(
              'Products',
              style: TextStyle(
                  fontFamily: 'SFCompactRounded', fontWeight: FontWeight.bold),
            ),
            activeColor: primaryCorlor,
          ),
          BottomBarItem(
            icon: Icon(
              Icons.shopping_cart_rounded,
            ),
            title: Text(
              'Cart',
              style: TextStyle(
                  fontFamily: 'SFCompactRounded', fontWeight: FontWeight.bold),
            ),
            activeColor: primaryCorlor,
          ),
          BottomBarItem(
            icon: Icon(Icons.person_rounded),
            title: Text(
              'Me',
              style: TextStyle(
                  fontFamily: 'SFCompactRounded', fontWeight: FontWeight.bold),
            ),
            activeColor: primaryCorlor,
          )
        ],
      ),
    );
  }
}
