import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:td_movie/ui/components/common/movie_item.dart';

import 'home_provider.dart';
import 'home_view_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  HomeProvider _provider;
  Future<List<HomeViewModel>> _movieListFuture;

  @override
  void initState() {
    super.initState();
    _provider = HomeProvider();
    _movieListFuture = _provider.getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.black,
        child: FutureBuilder(
          future: _movieListFuture,
          builder: (BuildContext context,
              AsyncSnapshot<List<HomeViewModel>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: EdgeInsets.only(top: 16),
                itemCount: snapshot.data.length,
                itemBuilder: (context, row) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: _buildHomePageRow(snapshot.data[row]),
                  );
                },
              );
            }

            if (snapshot.hasError) {
              print("Error: ${snapshot.error}");
              return Center(
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 80.0,
                ),
              );
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16.0),
                  Text("Loading at the moment, please hold the line."),
                ],
              ),
            );
          },
        ),
      ),
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
              maxHeight: 400,
            ),
            child: ListView.builder(
              itemCount: model.items.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: ClampingScrollPhysics(),
              itemBuilder: (innerContext, column) {
                final movie = model.items[column];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: MovieItem(
                    movie: movie,
                    onTap: () {
                      print('Tapped: ${movie.title}');
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
