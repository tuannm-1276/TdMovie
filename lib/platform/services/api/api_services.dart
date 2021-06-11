import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:td_movie/domain/model/models.dart';
import 'package:td_movie/extension/string_ext.dart';
import 'package:td_movie/platform/services/api/response/movie_list.dart';
import 'package:td_movie/platform/services/api/urls.dart';

class Api {
  Api({
    Dio dio,
  }) : this.dio = dio ?? Dio() {
    this.dio
      ..interceptors.add(LogInterceptor())
      ..options.queryParameters.addAll(
        {'api_key': dotenv.env['API_KEY']},
      );
  }

  final Dio dio;

  Future<List<Movie>> getMovies(String type) async {
    final response =
        await dio.get('${Urls.movieUrl}/${type.toLowerCaseUnderScore()}');
    final movies = MovieList.fromJson(response.data).movies;
    return movies;
  }
}
