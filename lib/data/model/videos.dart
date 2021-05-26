import 'package:td_movie/data/model/result.dart';

class Videos {
  List<Result> results;

  Videos({
    this.results,
  });

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(
        results: List<Result>.from(
            json["results"].map((videoJson) => Result.fromJson(videoJson))),
      );
}
