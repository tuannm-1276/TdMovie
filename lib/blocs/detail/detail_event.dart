part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => runtimeType.toString();
}

class DetailLoaded extends DetailEvent {
  final int id;

  const DetailLoaded(this.id);
}
