import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:td_movie/domain/model/models.dart';
import 'package:td_movie/platform/repositories/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'movies_by_type_event.dart';

part 'movies_by_type_state.dart';

class MoviesByTypeBloc extends Bloc<MoviesByTypeEvent, MoviesByTypeState> {
  MoviesByTypeBloc({this.movieRepository}) : super(MoviesByTypeState());

  final MovieRepository movieRepository;

  @override
  Stream<Transition<MoviesByTypeEvent, MoviesByTypeState>> transformEvents(
    Stream<MoviesByTypeEvent> events,
    transitionFn,
  ) {
    // TODO: implement transformEvents
    return super.transformEvents(
      events.debounceTime(Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<MoviesByTypeState> mapEventToState(MoviesByTypeEvent event) async* {
    print('===MapEventToState - MovieByTypeBloc===');
    if (event is MovieListFetched) {
      yield await _mapMovieListFetchedToState(state, event.type);
    }
  }

  Future<MoviesByTypeState> _mapMovieListFetchedToState(
      MoviesByTypeState state, String type) async {
    if (state.isEndReached) return state;
    try {
      if (state.status == MovieListStatus.initial) {
        final movies = await movieRepository.getMoviesByType(type);
        return state.copyWith(
          status: MovieListStatus.success,
          movies: movies,
          isEndReached: false,
          page: state.page + 1,
        );
      }

      final movies =
          await movieRepository.getMoviesByType(type, state.page);
      return movies.isEmpty
          ? state.copyWith(isEndReached: true)
          : state.copyWith(
              status: MovieListStatus.success,
              movies: List.of(state.movies)..addAll(movies),
              isEndReached: false,
              page: state.page + 1,
            );
    } on Exception {
      return state.copyWith(status: MovieListStatus.failure);
    }
  }
}
