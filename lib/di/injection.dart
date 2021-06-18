import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:td_movie/platform/repositories/genres_repository.dart';
import 'package:td_movie/platform/repositories/movie_repository.dart';
import 'package:td_movie/platform/services/api/api.dart';

import '../platform/services/api/api.dart';

final getIt = GetIt.instance;

configureDependencies() async {
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerLazySingleton<Api>(
    () => Api(dio: getIt<Dio>()),
  );
  getIt.registerLazySingleton<MovieRepository>(
    () => MovieRepository(api: getIt.get<Api>()),
  );

  getIt.registerLazySingleton<GenresRepository>(
    () => GenresRepository(api: getIt.get<Api>()),
  );
}
