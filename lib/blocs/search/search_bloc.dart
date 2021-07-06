import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:meta/meta.dart';
import 'package:sealed_class/sealed_class.dart';
import 'package:td_movie/domain/model/models.dart';
import 'package:td_movie/platform/repositories/movie_repository.dart';

part 'search_event.dart';

part 'search_state.dart';

part 'search_bloc.g.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.movieRepository) : super(SearchEmptyState());

  final MovieRepository movieRepository;
  String _query = '';

  @override
  Stream<Transition<SearchEvent, SearchState>> transformEvents(
    Stream<SearchEvent> events,
    transitionFn,
  ) =>
      events
          .debounceTime(Duration(milliseconds: 300))
          .switchMap(transitionFn);

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is TextChangedEvent) {
      _query = event.query;
      yield await _mapTextChangedToState(event.query);
    }
    if (event is SearchLoadMoreEvent && state is SearchLoadSuccess) {
      yield* _mapLoadMoreToState(
        _query,
        (state as SearchLoadSuccess).page + 1,
      );
    }
  }

  Future<SearchState> _mapTextChangedToState(String query) async {
    if(query.isEmpty) {
      return SearchEmptyState();
    }

    try {
      final data = await movieRepository.searchMovies(query);
      return SearchLoadSuccess(data.movies, data.page, false);
    } catch (e) {
      print(e.toString());
      return SearchLoadFailure(e);
    }
  }

  Stream<SearchState> _mapLoadMoreToState(String query, int page) async* {
    print('Search bloc: $query - $page');
    if (state.isEndReached) {
      yield state;
    }

    try {
      final data = await movieRepository.searchMovies(query, page);
      final currentSuccessState = state as SearchLoadSuccess;
      yield data.movies.isEmpty
          ? currentSuccessState.copy(isEndReached: true)
          : currentSuccessState.copy(
              movies: List.of(currentSuccessState.movies)..addAll(data.movies),
              page: data.page + 1,
              isEndReached: false,
            );
    } catch (e) {
      print(e.toString());
      // yield SearchLoadFailure(e);
    }
  }
}
