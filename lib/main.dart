import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:td_movie/blocs/blocs.dart';
import 'package:td_movie/di/injection.dart';
import 'package:td_movie/platform/repositories/movie_repository.dart';
import 'package:td_movie/ui/components/bubble_bottom_navigation/bubble_bottom_navigation.dart';
import 'package:td_movie/ui/screen/favorite/favorite_page.dart';
import 'package:td_movie/ui/screen/genres/genres_page.dart';
import 'package:td_movie/ui/screen/search/search_page.dart';

import 'extension/iterable_ext.dart';
import 'ui/components/common/screen_with_tab.dart';
import 'ui/screen/home/home_page.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
  await configureDependencies();
  Bloc.observer = MovieBlocObserver();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      // Change it as you want
      theme: ThemeData(
          primaryColor: Colors.white,
          primaryColorBrightness: Brightness.light,
          brightness: Brightness.light,
          primaryColorDark: Colors.black,
          canvasColor: Colors.white,
          // next line is important!
          appBarTheme: AppBarTheme(brightness: Brightness.light)),
      darkTheme: ThemeData(
          primaryColor: Colors.black,
          primaryColorBrightness: Brightness.dark,
          primaryColorLight: Colors.black,
          brightness: Brightness.dark,
          primaryColorDark: Colors.black,
          indicatorColor: Colors.white,
          canvasColor: Colors.black,
          // next line is important!
          appBarTheme: AppBarTheme(brightness: Brightness.dark)),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> implements FavoriteDataHandle {
  int _currentPage = 0;
  final _screens = [
    ScreenWithTab(
      page: BlocProvider(
        create: (context) {
          return HomeBloc(
            movieRepository: getIt.get<MovieRepository>(),
          )..add(HomeLoaded());
        },
        child: HomePage(),
      ),
      title: 'Home',
      color: Colors.red,
      icon: Icons.home,
    ),
    ScreenWithTab(
      page: GenresLayout(),
      title: 'Genres',
      color: Colors.purple,
      icon: Icons.category,
    ),
    ScreenWithTab(
      page: FavoriteScreen(
        key: GlobalKey(),
      ),
      title: 'Favorite',
      color: Colors.teal,
      icon: Icons.favorite,
    ),
  ];

  void _changePage(int page) {
    if (page == 2) {
      _rebuildFavoriteScreen();
    }
    setState(() => _currentPage = page);
  }

  void _rebuildFavoriteScreen() {
    setState(
      () {
        _screens.removeAt(2);
        _screens.insert(
          2,
          ScreenWithTab(
            page: FavoriteScreen(
              key: GlobalKey(),
              favoriteDataHandle: this,
            ),
            title: 'Favorite',
            color: Colors.teal,
            icon: Icons.favorite,
          ),
        );
      },
    );
  }

  List<BubbleBottomNavigationBarItem> _buildBottomNavigationTabs() {
    return _screens.mapIndexed((index, screen) {
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
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.search_outlined,
              color: Colors.white,
            ),
            onPressed: _navigateToSearchPage,
          )
        ],
      ),
      body: IndexedStack(
        index: _currentPage,
        children: _screens.map((e) => e.page).toList(),
      ),
      bottomNavigationBar: BubbleBottomNavigationBar(
        hasNotch: true,
        opacity: .2,
        currentIndex: _currentPage,
        onTap: _changePage,
        backgroundColor: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        animationDuration: Duration(milliseconds: 300),
        items: _buildBottomNavigationTabs(),
      ),
    );
  }

  void _navigateToSearchPage() {
    final searchPage = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
        create: (_) => SearchBloc(getIt.get())..add(TextChangedEvent()),
        child: SearchPage(
          searchFieldLabel: 'Enter movie name',
        ),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = Offset(1.0, 0.0);
        final end = Offset.zero;
        final curveTween = CurveTween(curve: Curves.ease);
        final tween = Tween(begin: begin, end: end).chain(curveTween);
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
    Navigator.of(context).push(searchPage);
    // showSearch(context: context, delegate: MovieSearchDelegate(getIt.get()));
  }

  @override
  void update() {
    _rebuildFavoriteScreen();
  }
}

abstract class FavoriteDataHandle {
  void update();
}
