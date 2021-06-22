import 'package:td_movie/base/base.dart';
import 'package:td_movie/domain/model/movie.dart';

class GetFavorites extends BaseEvent {}

class CheckFavorite extends BaseEvent {
  final Movie movie;

  CheckFavorite(this.movie);
}

class ClickedFavorite extends BaseEvent{
  final Movie movie;

  ClickedFavorite(this.movie);
}

class UnFavorite extends BaseEvent{
  final Movie movie;

  UnFavorite(this.movie);
}
