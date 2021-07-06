
part of 'genres_bloc.dart';

@Sealed([GenresLoadSuccess, GenresLoadFailure, GenresLoadInProgress])
abstract class GenresState extends Equatable {
  const GenresState();

  @override
  List<Object> get props => [];

  @override
  String toString() => runtimeType.toString();
}

class GenresLoadInProgress extends GenresState {}

class GenresLoadSuccess extends GenresState {
  final List<Genre> genres;

  const GenresLoadSuccess(this.genres);

  @override
  // TODO: implement props
  List<Object> get props => [genres];

  @override
  String toString() =>
      '${super.toString()}: { genres: $genres }';
}

class GenresLoadFailure extends GenresState {
  final dynamic error;

  const GenresLoadFailure(this.error);

  @override
  String toString() => '${super.toString()}: { ${error.toString()} }';
}
