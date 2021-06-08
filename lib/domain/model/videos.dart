import 'package:json_annotation/json_annotation.dart';

import 'result.dart';

part 'videos.g.dart';

@JsonSerializable()
class Videos {
  List<Result> results;

  Videos({
    this.results,
  });

  factory Videos.fromJson(Map<String, dynamic> json) => _$VideosFromJson(json);

  Map<String, dynamic> toJson() => _$VideosToJson(this);
}
