import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:td_movie/base/base.dart';
import 'package:td_movie/blocs/movies_by_genre/blocs.dart';
import 'package:td_movie/domain/model/genre.dart';
import 'package:td_movie/domain/model/models.dart';
import 'package:td_movie/platform/services/api/api.dart';
import 'package:td_movie/ui/components/common/movie_item.dart';
import 'package:td_movie/ui/components/common/progress_loading.dart';
import 'package:td_movie/ui/components/common/route_to_detail.dart';

class MoviesByGenrePage extends StatefulWidget {
  final Genre genre;

  const MoviesByGenrePage({Key key, this.genre}) : super(key: key);

  @override
  _MoviesByGenrePageState createState() => _MoviesByGenrePageState();
}

class _MoviesByGenrePageState extends State<MoviesByGenrePage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 20;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.genre.name,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(12.0),
        child: BlocBuilder<MoviesByGenreBloc, BaseState>(
          builder: (context, state) {
            if (state is LoadedState<MovieList>) {
              final List<Movie> movies = state.data.movies ?? [];
              return GridView.count(
                controller: _scrollController,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: (1 / 2),
                crossAxisCount: 2,
                children: List.generate(
                  state.data.page < state.data.totalPages
                      ? movies.length + 1
                      : movies.length,
                  (index) => index < movies.length
                      ? GestureDetector(
                          child: MovieItem(movie: movies[index]),
                          onTap: () {
                            Navigator.of(context).push(
                              navigateToDetail(movies[index]),
                            );
                          },
                        )
                      : Center(
                          child: ProgressLoading(
                            size: 20,
                          ),
                        ),
                ),
              );
            }
            return Center(
              child: ProgressLoading(size: 24),
            );
          },
        ),
      ),
    );
  }

  _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      BlocProvider.of<MoviesByGenreBloc>(context)
          .add(LoadMoreMoviesByGenre(widget.genre));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
