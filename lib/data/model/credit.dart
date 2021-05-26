import 'cast.dart';

class Credits {
  List<Cast> cast;
  List<Cast> crew;

  Credits({
    this.cast,
    this.crew,
  });

  factory Credits.fromJson(Map<String, dynamic> json) => Credits(
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromJson(x))),
      );
}
