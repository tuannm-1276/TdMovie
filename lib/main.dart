import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:td_movie/ui/components/bubble_bottom_navigation/bubble_bottom_navigation.dart';

import 'extension/iterable_ext.dart';
import 'ui/components/common/screen_with_tab.dart';
import 'ui/screen/home/home_page.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(statusBarColor: Colors.black),
        child: MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  final screens = <ScreenWithTab>[
    ScreenWithTab(
      page: HomePage(),
      title: 'Home',
      color: Colors.red,
      icon: Icons.home,
    ),
    ScreenWithTab(
      page: Container(),
      title: 'Categories',
      color: Colors.purple,
      icon: Icons.category,
    ),
    ScreenWithTab(
      page: Container(),
      title: 'Favorite',
      color: Colors.teal,
      icon: Icons.favorite,
    ),
  ];

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentPage = 0;

  void _changePage(int page) {
    setState(() => _currentPage = page);
  }

  List<BubbleBottomNavigationBarItem> _buildBottomNavigationTabs() {
    return widget.screens.mapIndexed((index, screen) {
      return BubbleBottomNavigationBarItem(
        title: Text(screen.title),
        icon: Icon(screen.icon, color: screen.color),
        activeIcon: Icon(screen.icon, color: screen.color),
        backgroundColor: screen.color,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: widget.screens[_currentPage].page,
      ),
      bottomNavigationBar: BubbleBottomNavigationBar(
        hasNotch: true,
        opacity: .2,
        currentIndex: _currentPage,
        onTap: _changePage,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        animationDuration: Duration(milliseconds: 300),
        items: _buildBottomNavigationTabs(),
      ),
    );
  }
}
