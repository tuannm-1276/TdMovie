
import 'genre.dart';

class Genres {
  Genres({
    this.genres,
  });

  List<Genre> genres;

  factory Genres.fromJson(Map<String, dynamic> json) => Genres(
    genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
  );
}