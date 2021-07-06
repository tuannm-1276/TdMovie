part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent({this.query: ''});

  final String query;

  @override
  List<Object> get props => [query];

  @override
  String toString() {
    return runtimeType.toString() + ' { query: $query }';
  }
}

class TextChangedEvent extends SearchEvent {
  const TextChangedEvent({String query: ''}) : super(query: query);
}

class SearchLoadMoreEvent extends SearchEvent {
  const SearchLoadMoreEvent({String query: ''}): super(query: query);
}
