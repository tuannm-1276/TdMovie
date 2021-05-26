import 'belongs_to_collection.dart';
import 'credit.dart';
import 'enum.dart';
import 'genre.dart';
import 'production_company.dart';
import 'production_country.dart';
import 'spoken_language.dart';
import 'videos.dart';

class Movie {
  bool adult;
  String backdropPath;
  BelongsToCollection belongsToCollection;
  int budget;
  List<Genre> genres;
  String homepage;
  int id;
  String imdbId;
  OriginalLanguage originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  List<ProductionCompany> productionCompanies;
  List<ProductionCountry> productionCountries;
  DateTime releaseDate;
  int revenue;
  int runtime;
  List<SpokenLanguage> spokenLanguages;
  String status;
  String tagline;
  String title;
  bool video;
  double voteAverage;
  int voteCount;
  Videos videos;
  Credits credits;

  Movie({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.videos,
    this.credits,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json["id"],
        title: json["title"],
        video: json["video"],
        overview: json["overview"],
        voteAverage: json["vote_average"].toDouble(),
        backdropPath: json["backdrop_path"],
        posterPath: json["poster_path"],

        adult: json["adult"],
        budget: json["budget"],
        homepage: json["homepage"],
        imdbId: json["imdb_id"],
        originalTitle: json["original_title"],
        popularity: json["popularity"].toDouble(),
        revenue: json["revenue"],
        runtime: json["runtime"],
        status: json["status"],
        tagline: json["tagline"],
        voteCount: json["vote_count"],

        videos: Videos.fromJson(json["videos"]),
        credits: Credits.fromJson(json["credits"]),
        releaseDate: DateTime.parse(json["release_date"]),

        originalLanguage: originalLanguageValues.map[json["original_language"]],

        belongsToCollection:
            BelongsToCollection.fromJson(json["belongs_to_collection"]),

        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),

        productionCompanies: json["production_companies"]
                ?.map((x) => ProductionCompany.fromJson(x))
                ?.toList() ?? [],

        productionCountries: List<ProductionCountry>.from(
            json["production_countries"]
                .map((x) => ProductionCountry.fromJson(x))),
        
        spokenLanguages: List<SpokenLanguage>.from(
            json["spoken_languages"].map((x) => SpokenLanguage.fromJson(x))),
      );
}
