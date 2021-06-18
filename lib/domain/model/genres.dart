
import 'package:json_annotation/json_annotation.dart';

import 'genre.dart';
part 'genres.g.dart';

@JsonSerializable()
class Genres {
  Genres({
    this.genres,
  });

  List<Genre> genres;

  factory Genres.fromJson(Map<String, dynamic> json) => _$GenresFromJson(json);

  Map<String, dynamic> toJson() => _$GenresToJson(this);
}
