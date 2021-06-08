import 'package:json_annotation/json_annotation.dart';

import 'enum.dart';

part 'cast.g.dart';

@JsonSerializable()
class Cast {
  Cast({
    this.adult,
    this.gender,
    this.id,
    @JsonKey(name: 'known_for_department') this.knownForDepartment,
    this.name,
    @JsonKey(name: 'original_name') this.originalName,
    this.popularity,
    @JsonKey(name: 'profile_path') this.profilePath,
    @JsonKey(name: 'cast_id') this.castId,
    this.character,
    @JsonKey(name: 'credit_id') this.creditId,
    this.order,
    this.job,
  });

  bool adult;
  int gender;
  int id;
  Department knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;
  String job;

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);

  Map<String, dynamic> toJson() => _$CastToJson(this);
}
