import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'components/bubble_bottom_navigation_bar.dart';
import 'components/bubble_bottom_navigation_bar_item.dart';
import 'extension/iterable_ext.dart';

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
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  final _titles = ['Home', 'Categories', 'Favorite'];
  final _colors = [Colors.red, Colors.purple, Colors.teal];
  final _icons = [Icons.home, Icons.category, Icons.favorite];

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
      keepPage: false,
      viewportFraction: 1.0,
    );
    super.initState();
  }

  void _changePage(int page) {
    setState(() => _currentPage = page);
    _pageController.jumpToPage(page);
  }

  List<Widget> _buildPageViewScreens() {
    return widget._titles.mapIndexed((index, title) {
      return Container(
        color: widget._colors[index],
        child: Center(child: Text(title)),
      );
    }).toList();
  }

  List<BubbleBottomNavigationBarItem> _buildBottomNavigationTabs() {
    return widget._titles.mapIndexed((index, title) {
      return BubbleBottomNavigationBarItem(
        title: Text(title),
        icon: Icon(widget._icons[index], color: widget._colors[index]),
        activeIcon: Icon(widget._icons[index], color: widget._colors[index]),
        backgroundColor: widget._colors[index],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: BouncingScrollPhysics(),
          onPageChanged: (page) => setState(() => _currentPage = page),
          children: _buildPageViewScreens(),
        ),
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
