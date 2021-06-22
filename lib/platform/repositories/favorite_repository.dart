import 'package:td_movie/di/injection.dart';
import 'package:td_movie/domain/model/movie.dart';
import 'package:td_movie/platform/database/database.dart';

class FavoriteRepository {
  DatabaseProvider databaseProvider = getIt<DatabaseProvider>();

  Future<int> addFavorite(Movie movie) {
    return databaseProvider.insertMovie(movie);
  }

  Future<bool> isFavorite(Movie movie) {
    return databaseProvider.existMovie(movie);
  }

  Future<List<Movie>> getFavorites() {
    return databaseProvider.getMovies();
  }

  Future<bool> deleteFavorite(Movie movie) {
    return databaseProvider.deleteMovie(movie);
  }
}
