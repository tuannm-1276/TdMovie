import 'package:td_movie/base/base.dart';
import 'package:td_movie/domain/model/genre.dart';

class GetMoviesByGenre extends BaseEvent {
  final Genre genre;

  GetMoviesByGenre(this.genre);
}

class LoadMoreMoviesByGenre extends BaseEvent {
  final Genre genre;

  LoadMoreMoviesByGenre(this.genre);
}
