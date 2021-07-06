import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:td_movie/blocs/genres/genres_bloc.dart';
import 'package:td_movie/blocs/movies_by_genre/blocs.dart';
import 'package:td_movie/platform/repositories/genres_repository.dart';
import 'package:td_movie/platform/repositories/movie_repository.dart';
import 'package:td_movie/ui/components/common/route_to_detail.dart';
import 'package:td_movie/ui/screen/genres/movies_by_genre_page.dart';

import '../../../di/injection.dart';
import '../../../domain/model/genre.dart';

class GenresLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GenresBloc(
        genresRepository: getIt.get<GenresRepository>(),
      )..add(
          GenresLoaded(),
        ),
      child: GenresView(),
    );
  }
}

class GenresView extends StatelessWidget {
  const GenresView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: _getImage(),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: BlocBuilder<GenresBloc, GenresState>(
            builder: (context, state) {
              return state.switchResult(
                onGenresLoadSuccess: (state) {
                  return StaggeredGenres(state.genres);
                },
                onGenresLoadFailure: (state) {
                  return _getFailureContainer(state);
                },
                onGenresLoadInProgress: (state) {
                  return _getInProgressContainer(state);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class StaggeredGenres extends StatelessWidget {
  final List<Genre> genres;

  StaggeredGenres(List<Genre> genres) : genres = genres;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.count(
      crossAxisCount: 4,
      staggeredTiles: _staggeredTiles,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      padding: const EdgeInsets.all(4),
      children: _getTiles(genres),
    );
  }
}

const List<StaggeredTile> _staggeredTiles = <StaggeredTile>[
  StaggeredTile.count(2, 2),
  StaggeredTile.count(2, 1),
  StaggeredTile.count(1, 2),
  StaggeredTile.count(1, 1),
  StaggeredTile.count(2, 2),
  StaggeredTile.count(1, 2),
  StaggeredTile.count(1, 1),
  StaggeredTile.count(3, 1),
  StaggeredTile.count(1, 1),
  StaggeredTile.count(4, 1),
  StaggeredTile.count(2, 2),
  StaggeredTile.count(2, 1),
  StaggeredTile.count(1, 2),
  StaggeredTile.count(1, 1),
  StaggeredTile.count(2, 2),
  StaggeredTile.count(1, 2),
  StaggeredTile.count(1, 1),
  StaggeredTile.count(3, 1),
  StaggeredTile.count(1, 1),
];

List<_Tile> _getTiles(List<Genre> genres) {
  List tiles = <_Tile>[];

  genres.asMap().forEach((index, genre) {
    tiles.add(_Tile(colors[index], icons[index], genre));
  });

  return tiles;
}

const List<IconData> icons = [
  Icons.widgets,
  Icons.ac_unit,
  Icons.animation,
  Icons.map,
  Icons.alternate_email,
  Icons.all_inclusive,
  Icons.account_balance_rounded,
  Icons.home_work,
  Icons.desktop_windows,
  Icons.radio,
  Icons.agriculture_outlined,
  Icons.queue_music,
  Icons.panorama_wide_angle,
  Icons.map,
  Icons.assistant_direction,
  Icons.desktop_windows,
  Icons.album_outlined,
  Icons.add_moderator,
  Icons.queue,
];

const List<Color> colors = [
  Colors.transparent,
  Colors.lightBlue,
  Colors.amber,
  Colors.brown,
  Colors.white70,
  Colors.indigo,
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.transparent,
  Colors.green,
  Colors.lightBlue,
  Colors.white54,
  Colors.brown,
  Colors.transparent,
  Colors.indigo,
  Colors.red,
  Colors.purple,
  Colors.blue,
];

class _Tile extends StatelessWidget {
  const _Tile(this.backgroundColor, this.iconData, this.genre);

  final Color backgroundColor;
  final IconData iconData;
  final Genre genre;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: backgroundColor,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(navigateToMoviesByGenre(genre));
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  color: Colors.white,
                ),
                Text(
                  genre.name.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _getFailureContainer(GenresLoadFailure state) {
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
          Text('${state.error.toString()}'),
        ],
      ),
    ),
  );
}

Widget _getInProgressContainer(GenresLoadInProgress state) {
  return Container(
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
}

Route navigateToMoviesByGenre(Genre genre) {
  return PageRouteBuilder(
    pageBuilder: (
      context,
      animation,
      secondaryAnimation,
    ) => BlocProvider(
      create: (context) => MoviesByGenreBloc(getIt.get<MovieRepository>())
        ..add(GetMoviesByGenre(genre)),
      child: MoviesByGenrePage(
        genre: genre,
      ),
    ),
    transitionsBuilder: (
      context,
      animation,
      secondaryAnimation,
      child,
    ) => buildCommonTransitions(
      context,
      animation,
      secondaryAnimation,
      child,
    ),
  );
}

_getImage() {
  final _random = Random();
  int imageIndex = 1 + _random.nextInt(4);
  switch (imageIndex) {
    case 1:
      return AssetImage("assets/images/wrath_of_man.jpeg");
      break;
    case 2:
      return AssetImage("assets/images/nobody.jpeg");
      break;
    case 3:
      return AssetImage("assets/images/raya.jpeg");
      break;
    case 4:
      return AssetImage("assets/images/mortal_kombat.jpeg");
      break;
    case 5:
      return AssetImage("assets/images/the_tomorrow_war.jpeg");
      break;
    default:
      return AssetImage("assets/images/wrath_of_man.jpeg");
  }
}
