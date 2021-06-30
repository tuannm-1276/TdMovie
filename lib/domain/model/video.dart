import 'package:json_annotation/json_annotation.dart';

part 'video.g.dart';

@JsonSerializable()
class Video {
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'key')
  String key;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'size')
  int size;
  @JsonKey(name: 'type')
  String type;

  Video({
    this.id,
    this.key,
    this.name,
    this.size,
    this.type,
  });

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);
}
