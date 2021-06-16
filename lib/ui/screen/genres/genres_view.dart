import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:td_movie/domain/model/genre.dart';
import 'package:td_movie/domain/model/genres.dart';

import '../../../domain/model/genre.dart';
import '../../../platform/repositories/genres_repository.dart';
import '../../../platform/services/api/api_services.dart';

class GenresLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg_genres.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: FutureBuilder<List<Genre>>(
            future: fetchGenres(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print('$snapshot.error');

              return snapshot.hasData
                  ? StaggeredGenres(
                      genres: snapshot.data,
                    )
                  : Center(
                      child: CircularProgressIndicator(),
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

  StaggeredGenres({this.genres});

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
  //StaggeredTile.count(4, 1),
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
  //Icons.radio,
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
        onTap: () {},
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

Future<List<Genre>> fetchGenres() async {
  List<Genre> genres = await GenresRepository(api: Api()).getGenres();

  return genres;
}
