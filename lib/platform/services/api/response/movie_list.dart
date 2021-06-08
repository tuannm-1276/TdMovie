import 'package:json_annotation/json_annotation.dart';
import 'package:td_movie/domain/model/models.dart';

part 'movie_list.g.dart';

@JsonSerializable()
class MovieList {
  Dates dates;
  int page;
  @JsonKey(name: 'results')
  List<Movie> movies;
  @JsonKey(name: 'total_pages')
  int totalPages;
  @JsonKey(name: 'total_results')
  int totalResults;

  MovieList(
      {this.dates, this.page, this.movies, this.totalPages, this.totalResults});

  factory MovieList.fromJson(Map<String, dynamic> json) =>
      _$MovieListFromJson(json);

  Map<String, dynamic> toJson() => _$MovieListToJson(this);
}
