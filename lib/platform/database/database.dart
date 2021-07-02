import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:td_movie/domain/model/movie.dart';

const String DB_NAME = "td_movies.db";
const String TABLE_FAVORITE = "favorite";

class DatabaseProvider {
  static final DatabaseProvider databaseProvider = DatabaseProvider._();
  Database _database;

  DatabaseProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), DB_NAME),
      version: 1,
      onCreate: (db, version) {
        return db.execute("""CREATE TABLE $TABLE_FAVORITE (
            id INTEGER PRIMARY KEY,
            poster_path TEXT,
            title TEXT,
            release_date TEXT,
            vote_average REAL
        )""");
      },
    );
  }

  Future close() {
    return _database?.close();
  }

  Future deleteDB() async {
    return deleteDatabase(join(await getDatabasesPath(), DB_NAME));
  }

  Future<int> insertMovie(Movie movie) async {
    final db = await database;
    return await db.insert(TABLE_FAVORITE, movie.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<bool> existMovie(Movie movie) async {
    final db = await database;
    List<Map<String, dynamic>> maps =
        await db.query(TABLE_FAVORITE, where: "id = ?", whereArgs: [movie.id]);
    return maps.isNotEmpty;
  }

  Future<List<Movie>> getMovies() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(TABLE_FAVORITE);
    return List.generate(
      maps.length,
      (index) {
        return Movie(
          id: maps[index]['id'],
          posterPath: maps[index]['poster_path'],
          title: maps[index]['title'],
          releaseDate: maps[index]['release_date'],
          voteAverage: maps[index]['vote_average'],
        );
      },
    );
  }

  Future<bool> deleteMovie(Movie movie) async {
    final db = await database;
    final result =
        await db.delete(TABLE_FAVORITE, where: "id = ?", whereArgs: [movie.id]);
    return result >= 0;
  }

  Future<bool> updateMovie(Movie movie) async {
    final db = await database;
    final result = await db.update(TABLE_FAVORITE, movie.toMap(),
        where: "id = ?", whereArgs: [movie.id]);
    return result >= 0;
  }
}
