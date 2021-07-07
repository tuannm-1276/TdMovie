import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:td_movie/base/base_state.dart';
import 'package:td_movie/blocs/movies_by_type/movies_by_type_bloc.dart';
import 'package:td_movie/blocs/movies_by_type/movies_by_type_event.dart';
import 'package:td_movie/domain/model/movie.dart';
import 'package:td_movie/platform/services/api/response/movie_list.dart';
import 'package:td_movie/ui/components/common/movie_item.dart';
import 'package:td_movie/ui/components/common/progress_loading.dart';
import 'package:td_movie/ui/components/common/route_to_detail.dart';

class MoviesByTypePage extends StatefulWidget {
  final String type;

  const MoviesByTypePage({Key key, this.type}) : super(key: key);

  @override
  _MoviesByTypePageState createState() => _MoviesByTypePageState();
}

class _MoviesByTypePageState extends State<MoviesByTypePage> {
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
          widget.type,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(12.0),
        child: BlocBuilder<MoviesByTypeBloc, BaseState>(
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
                    child: MovieItem(
                      movie: movies[index],
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        navigateToDetail(movies[index]),
                      );
                    },
                  )
                      : Center(
                    child: ProgressLoading(
                      size: 28,
                    ),
                  ),
                ),
              );
            }
            return Center(
              child: ProgressLoading(size: 32),
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
      BlocProvider.of<MoviesByTypeBloc>(context)
          .add(LoadMoreMoviesByType(widget.type));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
