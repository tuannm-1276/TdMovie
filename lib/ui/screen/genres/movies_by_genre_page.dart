import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:td_movie/base/base.dart';
import 'package:td_movie/blocs/movies_by_genre/blocs.dart';
import 'package:td_movie/domain/model/genre.dart';
import 'package:td_movie/domain/model/models.dart';
import 'package:td_movie/ui/components/common/movie_item.dart';
import 'package:td_movie/ui/components/common/progress_loading.dart';
import 'package:td_movie/ui/components/common/route_to_detail.dart';

class MoivesByGenrePage extends StatelessWidget {
  final Genre genre;

  MoivesByGenrePage(this.genre);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          genre.name,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(12.0),
        child: BlocBuilder<MoviesByGenreBloc, BaseState>(
            builder: (context, state) {
          if (state is LoadedState) {
            final List<Movie> movies = state.data ?? [];
            return GridView.count(
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              childAspectRatio: (1 / 2),
              crossAxisCount: 2,
              children: List.generate(
                movies.length,
                (index) => GestureDetector(
                  child: MovieItem(movie: movies[index]),
                  onTap: () {
                    Navigator.of(context).push(
                      navigateToDetail(movies[index]),
                    );
                  },
                ),
              ),
            );
          }
          return Center(
            child: ProgressLoading(size: 24),
          );
        }),
      ),
    );
  }
}
