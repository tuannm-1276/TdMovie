
part of 'genres_bloc.dart';

abstract class GenresEvent extends Equatable{
  const GenresEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => runtimeType.toString();
}

class GenresLoaded extends GenresEvent{}
