part of 'movies_by_type_bloc.dart';

enum MovieListStatus { initial, success, failure }

class MoviesByTypeState extends Equatable {
  const MoviesByTypeState({
    this.status = MovieListStatus.initial,
    this.movies = const [],
    this.isEndReached = false,
    this.page = 1,
  });

  final MovieListStatus status;
  final List<Movie> movies;
  final bool isEndReached;
  final int page;

  MoviesByTypeState copyWith({
    MovieListStatus status,
    List<Movie> movies,
    bool isEndReached,
    int page,
  }) =>
      MoviesByTypeState(
        status: status ?? this.status,
        movies: movies ?? this.movies,
        isEndReached: isEndReached ?? this.isEndReached,
        page: page ?? this.page,
      );

  @override
  List<Object> get props => [status, movies, isEndReached, page];

  @override
  String toString() {
    return '''PostState { status: $status, page: $page, hasReachedMax: $isEndReached, movies: ${movies.length} }''';
  }
}
