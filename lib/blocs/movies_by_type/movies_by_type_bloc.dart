import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:td_movie/base/base.dart';
import 'package:td_movie/platform/repositories/movie_repository.dart';
import 'package:td_movie/platform/services/api/api.dart';

import 'blocs.dart';

class MoviesByTypeBloc extends Bloc<BaseEvent, BaseState> {
  final MovieRepository movieRepository;

  MoviesByTypeBloc(this.movieRepository) : super(InitState());

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is GetMoviesByType) {
      try {
        yield LoadingState();
        final movieList = await movieRepository.getMoviesByType(event.type);
        yield LoadedState(data: movieList);
      } catch (e) {
        yield (ErrorState(data: e.toString()));
      }
    }

    if (event is LoadMoreMoviesByType) {
      try {
        final movieList = (state as LoadedState<MovieList>).data;
        final movieListMore = await movieRepository.getMoviesByType(event.type,
            page: movieList.page + 1);

        movieListMore.movies = movieList.movies + movieListMore.movies;
        yield LoadedState(data: movieListMore);
      } catch (e) {
        yield (ErrorState(data: e.toString()));
      }
    }
  }
}
