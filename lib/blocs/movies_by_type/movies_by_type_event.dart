part of 'movies_by_type_bloc.dart';

abstract class MoviesByTypeEvent extends Equatable {
  const MoviesByTypeEvent();

  @override
  List<Object> get props => [];
}

class MovieListFetched extends MoviesByTypeEvent {
  final String type;

  const MovieListFetched(this.type);
}
