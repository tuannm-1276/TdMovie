import 'package:json_annotation/json_annotation.dart';

import 'video.dart';
part 'video_list.g.dart';

@JsonSerializable()
class VideoList {
  @JsonKey(name: 'results')
  List<Video> videos;

  VideoList({
    this.videos,
  });

  factory VideoList.fromJson(Map<String, dynamic> json) => _$VideoListFromJson(json);

  Map<String, dynamic> toJson() => _$VideoListToJson(this);
}
