import 'package:td_movie/domain/model/models.dart';

class DetailProvider {
  List<Genre> getGenres() {
    return [
      Genre(id: 28, name: 'Action'),
      Genre(id: 12, name: 'Adventure'),
      Genre(id: 16, name: 'Animation'),
      Genre(id: 35, name: 'Comedy'),
      Genre(id: 80, name: 'Crime'),
      Genre(id: 99, name: 'Documentary'),
      Genre(id: 18, name: 'Drama'),
      Genre(id: 10751, name: 'Family'),
      Genre(id: 14, name: 'Fantasy'),
      Genre(id: 36, name: 'History'),
      Genre(id: 27, name: 'Horror'),
      Genre(id: 10402, name: 'Music'),
      Genre(id: 9648, name: 'Mystery'),
      Genre(id: 10749, name: 'Romance'),
      Genre(id: 878, name: 'Science Fiction'),
      Genre(id: 10770, name: 'TV Movie'),
      Genre(id: 53, name: 'Thriller'),
      Genre(id: 10752, name: 'War'),
      Genre(id: 37, name: 'Western'),
    ];
  }

  List<Cast> getCasts() {
    return List.generate(
      20,
      (index) => Cast(
        adult: false,
        gender: 1,
        id: 54693,
        knownForDepartment: Department.ACTING,
        name: 'Emma Stone',
        originalName: 'Emma Stone',
        popularity: 43.611,
        profilePath: '/2hwXbPW2ffnXUe1Um0WXHG0cTwb.jpg',
        castId: 0,
        character: 'Estella / Cruella',
        creditId: '59a50d419251412f02004a64',
        order: 0,
      ),
    );
  }

  List<ProductionCompany> getProductionCompanies() {
    return List.generate(
      20,
      (index) => ProductionCompany(
          id: 2,
          logoPath: "/wdrCwmRnLFJhEoH8GSfymY85KHT.png",
          name: "Walt Disney Pictures",
          originCountry: "US"),
    );
  }
}
