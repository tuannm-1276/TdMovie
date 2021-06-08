import 'package:json_annotation/json_annotation.dart';

import 'enum.dart';

part 'result.g.dart';

@JsonSerializable()
class Result {
  String id;
  @JsonKey(name: 'iso_639_1')
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

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
