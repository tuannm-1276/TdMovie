class Urls {
  static const _baseUrl = 'https://api.themoviedb.org/3';
  static const movieUrl = '$_baseUrl/movie';

  // Image
  static const _baseImageUrl = 'https://image.tmdb.org/t/p';
  static const originalImagePath = '$_baseImageUrl/original';
  static const w500ImagePath = '$_baseImageUrl/w500';

  // genres
  static const genresListPath = '$_baseUrl/genre/movie/list';

  // movies by genre
  static const moviesByGenresPath = '$_baseUrl/discover/movie';
}
