import 'package:td_movie/base/base.dart';

class GetMoviesByType extends BaseEvent{
  final String type;

  GetMoviesByType(this.type);
}

class LoadMoreMoviesByType extends BaseEvent{
  final String type;

  LoadMoreMoviesByType(this.type);
}
