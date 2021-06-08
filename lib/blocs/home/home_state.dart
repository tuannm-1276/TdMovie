part of 'home_bloc.dart';

@sealed
@Sealed([HomeLoadSuccess, HomeLoadInProgress, HomeLoadFailure])
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];

  @override
  String toString() => runtimeType.toString();
}

class HomeLoadInProgress extends HomeState {}

class HomeLoadSuccess extends HomeState {
  final List<HomeViewModel> data;

  const HomeLoadSuccess([this.data = const []]);

  @override
  List<Object> get props => [data];

  @override
  String toString() => '${super.toString()}: { $data }';
}

class HomeLoadFailure extends HomeState {
  final dynamic error;

  const HomeLoadFailure(this.error);

  @override
  String toString() => '${super.toString()}: { ${error.toString()} }';
}
