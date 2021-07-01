import 'package:json_annotation/json_annotation.dart';

enum Department {
  @JsonValue('Acting')
  ACTING,
  @JsonValue('Art')
  ART,
  @JsonValue('Production')
  PRODUCTION,
  @JsonValue('Camera')
  CAMERA,
  @JsonValue('Sound')
  SOUND,
  @JsonValue('Editing')
  EDITING,
  @JsonValue('Directing')
  DIRECTING,
  @JsonValue('Costume & Make-Up')
  COSTUME_MAKE_UP,
  @JsonValue('Writing')
  WRITING,
  @JsonValue('Lighting')
  LIGHTING,
  @JsonValue('Crew')
  CREW,
  @JsonValue('Visual Effects')
  VISUAL_EFFECTS,
  @JsonValue('Creator')
  CREATOR,
}

enum OriginalLanguage {
  @JsonValue('en')
  ENGLISH,
  @JsonValue('ja')
  JAPANESE,
  @JsonValue('ko')
  KOREAN,
}

enum Iso31661 {
  @JsonValue('US')
  US
}

enum Site {
  @JsonValue('YouTube')
  YOU_TUBE
}

enum Type {
  @JsonValue('Trailer')
  TRAILER,
  @JsonValue('Clip')
  CLIP,
  @JsonValue('Clip')
  TEASER
}
