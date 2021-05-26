import 'enum.dart';

class Result {
  String id;
  OriginalLanguage iso6391;
  Iso31661 iso31661;
  String key;
  String name;
  Site site;
  int size;
  Type type;

  Result({
    this.id,
    this.iso6391,
    this.iso31661,
    this.key,
    this.name,
    this.site,
    this.size,
    this.type,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        iso6391: originalLanguageValues.map[json["iso_639_1"]],
        iso31661: iso31661Values.map[json["iso_3166_1"]],
        key: json["key"],
        name: json["name"],
        site: siteValues.map[json["site"]],
        size: json["size"],
        type: typeValues.map[json["type"]],
      );
}
