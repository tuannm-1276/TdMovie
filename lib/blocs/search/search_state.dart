part of 'search_bloc.dart';

@sealed
@Sealed([
  SearchLoadSuccess,
  SearchEmptyState,
  SearchLoadInProgress,
  SearchLoadFailure,
])
abstract class SearchState extends Equatable {
  const SearchState({this.isEndReached: false});

  final bool isEndReached;

  List<Object> get props => [isEndReached];

  @override
  String toString() {
    return runtimeType.toString();
  }
}

class SearchEmptyState extends SearchState {}

class SearchLoadSuccess extends SearchState {
  const SearchLoadSuccess(this.movies, this.page, bool isEndReached)
      : super(isEndReached: isEndReached);

  final List<Movie> movies;
  final int page;

  @override
  List<Object> get props => super.props + [movies, page];

  SearchLoadSuccess copy({List<Movie> movies, int page, bool isEndReached}) =>
      SearchLoadSuccess(
        movies ?? this.movies,
        page ?? this.page,
        isEndReached ?? this.isEndReached,
      );

  @override
  String toString() {
    return super.toString() + '{ movies: $movies, page: $page }';
  }
}

class SearchLoadInProgress extends SearchState {}

class SearchLoadFailure extends SearchState {
  const SearchLoadFailure(this.error);

  final dynamic error;

  @override
  List<Object> get props => super.props + [error];

  @override
  String toString() {
    return super.toString() + '{ error: $error }';
  }
}
