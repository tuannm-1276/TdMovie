import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:td_movie/base/base.dart';
import 'package:td_movie/blocs/movies_by_genre/blocs.dart';
import 'package:td_movie/platform/repositories/movie_repository.dart';
import 'package:td_movie/platform/services/api/api.dart';

class MoviesByGenreBloc extends Bloc<BaseEvent, BaseState> {
  final MovieRepository movieRepository;

  MoviesByGenreBloc(@required this.movieRepository) : super(InitState());

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is GetMoviesByGenre) {
      try {
        yield LoadingState();
        final movieList =
            await movieRepository.getMovieListByGenre(event.genre.id);
        yield LoadedState(data: movieList);
      } catch (e) {
        yield (ErrorState(data: e.toString()));
      }
    }

    if (event is LoadMoreMoviesByGenre) {
      try {
        final movieList = (state as LoadedState<MovieList>).data;
        final movieListMore = await movieRepository.getMovieListByGenre(
          event.genre.id,
          page: movieList.page + 1,
        );
        movieListMore.movies = movieList.movies + movieListMore.movies;
        yield LoadedState(data: movieListMore);
      } catch (e) {
        yield ErrorState(data: e.toString());
      }
    }
  }
}
