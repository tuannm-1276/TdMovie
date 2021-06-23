import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:td_movie/base/base.dart';
import 'package:td_movie/blocs/favorite/blocs.dart';
import 'package:td_movie/domain/model/movie.dart';
import 'package:td_movie/ui/components/common/movie_item.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteBloc(InitState())..add(GetFavorites()),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          margin: const EdgeInsets.all(12.0),
          child: BlocBuilder<FavoriteBloc, BaseState>(
            builder: (context, state) {
              if (state is LoadedState) {
                final List<Movie> movies = state.data ?? [];
                return GridView.count(
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                  childAspectRatio: (1 / 2),
                  crossAxisCount: 2,
                  children: List.generate(movies.length,
                      (index) => MovieItem(movie: movies[index])),
                );
              }
              return Center(
                child: ProgressLoading(
                  size: 24,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ProgressLoading extends StatelessWidget {
  final double size;
  final Color valueColor;
  final double strokeWidth;

  const ProgressLoading({
    Key key,
    this.size = 16,
    this.valueColor = Colors.black,
    this.strokeWidth = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(valueColor),
        strokeWidth: strokeWidth,
      ),
    );
  }
}
