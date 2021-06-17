part of 'detail_bloc.dart';

@sealed
@Sealed([DetailLoadSuccess, DetailLoadInProgress, DetailLoadFailure])
abstract class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];

  @override
  String toString() => runtimeType.toString();
}

class DetailLoadInProgress extends DetailState {}

class DetailLoadSuccess extends DetailState {
  final Movie movie;
  final Credits credits;

  const DetailLoadSuccess(this.movie, this.credits);

  @override
  // TODO: implement props
  List<Object> get props => [movie, credits];

  @override
  String toString() =>
      '${super.toString()}: { movie: $movie,\ncredits: { $credits } }';
}

class DetailLoadFailure extends DetailState {
  final dynamic error;

  const DetailLoadFailure(this.error);

  @override
  String toString() => '${super.toString()}: { ${error.toString()} }';
}
