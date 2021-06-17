import 'package:json_annotation/json_annotation.dart';

import 'enum.dart';

part 'cast.g.dart';

@JsonSerializable()
class Cast {
  Cast({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
  });

  bool adult;
  int gender;
  int id;
  @JsonKey(name: 'known_for_department')
  Department knownForDepartment;
  String name;
  @JsonKey(name: 'original_name')
  String originalName;
  double popularity;
  @JsonKey(name: 'profile_path')
  String profilePath;
  @JsonKey(name: 'cast_id')
  int castId;
  String character;
  @JsonKey(name: 'credit_id')
  String creditId;
  int order;

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);

  Map<String, dynamic> toJson() => _$CastToJson(this);
}
