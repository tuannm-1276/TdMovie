enum Department {
  ACTING,
  ART,
  PRODUCTION,
  CAMERA,
  SOUND,
  EDITING,
  DIRECTING,
  COSTUME_MAKE_UP,
  WRITING,
  LIGHTING,
  CREW,
  VISUAL_EFFECTS,
}

final departmentValues = EnumValues({
  "Acting": Department.ACTING,
  "Art": Department.ART,
  "Camera": Department.CAMERA,
  "Costume & Make-Up": Department.COSTUME_MAKE_UP,
  "Crew": Department.CREW,
  "Directing": Department.DIRECTING,
  "Editing": Department.EDITING,
  "Lighting": Department.LIGHTING,
  "Production": Department.PRODUCTION,
  "Sound": Department.SOUND,
  "Visual Effects": Department.VISUAL_EFFECTS,
  "Writing": Department.WRITING
});

enum OriginalLanguage { EN }

final originalLanguageValues = EnumValues({"en": OriginalLanguage.EN});

enum Iso31661 { US }

final iso31661Values = EnumValues({"US": Iso31661.US});

enum Site { YOU_TUBE }

final siteValues = EnumValues({"YouTube": Site.YOU_TUBE});

enum Type { TRAILER, CLIP, TEASER }

final typeValues = EnumValues(
    {"Clip": Type.CLIP, "Teaser": Type.TEASER, "Trailer": Type.TRAILER});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
