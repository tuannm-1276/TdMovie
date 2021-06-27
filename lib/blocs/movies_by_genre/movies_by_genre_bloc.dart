import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:td_movie/base/base.dart';
import 'package:td_movie/blocs/movies_by_genre/blocs.dart';
import 'package:td_movie/platform/repositories/movie_repository.dart';

class MoviesByGenreBloc extends Bloc<BaseEvent, BaseState> {
  final MovieRepository movieRepository;

  MoviesByGenreBloc(@required this.movieRepository) : super(InitState());

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is GetMoviesByGenre) {
      try {
        yield LoadingState();
        final movies = await movieRepository.getMoviesByGenre(event.genre.id);
        yield LoadedState(data: movies);
      } catch (e) {
        yield (ErrorState(data: e.toString()));
      }
    }

    if (event is LoadMoreMoviesByGenre) {
      try {
        //TODO
      } catch (e) {
        yield (ErrorState(data: e.toString()));
      }
    }
  }
}
