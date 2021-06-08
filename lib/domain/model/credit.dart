import 'package:json_annotation/json_annotation.dart';

import 'cast.dart';

part 'credit.g.dart';

@JsonSerializable()
class Credits {
  @JsonKey(name: 'cast')
  List<Cast> casts;
  List<Cast> crew;

  Credits({
    this.casts,
    this.crew,
  });

  factory Credits.fromJson(Map<String, dynamic> json) =>
      _$CreditsFromJson(json);

  Map<String, dynamic> toJson() => _$CreditsToJson(this);
}
