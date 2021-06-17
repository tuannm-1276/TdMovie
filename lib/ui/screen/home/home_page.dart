import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:td_movie/blocs/blocs.dart';
import 'package:td_movie/di/injection.dart';
import 'package:td_movie/domain/model/models.dart';
import 'package:td_movie/platform/repositories/movie_repository.dart';
import 'package:td_movie/ui/components/common/movie_item.dart';
import 'package:td_movie/ui/screen/detail/detail_page.dart';

import 'home_view_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return state.switchResult(
          onHomeLoadSuccess: (successState) {
            return Container(
              color: Colors.black,
              child: SafeArea(
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 4),
                  itemCount: successState.data.length,
                  itemBuilder: (context, row) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: _buildHomePageRow(successState.data[row]),
                    );
                  },
                ),
              ),
            );
          },
          onHomeLoadFailure: (failState) {
            return Container(
              color: Colors.black,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 80.0,
                    ),
                    SizedBox(height: 16.0),
                    Text('${failState.error.toString()}'),
                  ],
                ),
              ),
            );
          },
          onHomeLoadInProgress: (loadingState) {
            return Container(
              color: Colors.black,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16.0),
                    Text(
                      'Loading at the moment, please hold the line.',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildHomePageRow(HomeViewModel model) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                model.headerTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            MaterialButton(
              child: Text(
                'Show All',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onPressed: () {},
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 300,
            ),
            child: ListView.builder(
              itemCount: model.items.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: ClampingScrollPhysics(),
              itemBuilder: (innerContext, column) {
                final movie = model.items[column];
                return InkWell(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: MovieItem(movie: movie),
                  ),
                  onTap: () {
                    Navigator.of(innerContext).push(_navigateToDetail(movie));
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Route _navigateToDetail(Movie movie) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
        create: (context) {
          return DetailBloc(movieRepository: getIt.get<MovieRepository>())
            ..add(DetailLoaded(movie.id));
        },
        child: DetailPage(),
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
  }
}
