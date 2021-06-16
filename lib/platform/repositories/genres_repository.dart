import 'package:flutter/material.dart';
import 'package:td_movie/domain/model/genre.dart';
import 'package:td_movie/platform/services/api/api.dart';

class GenresRepository {
  final Api api;

  GenresRepository({@required this.api});

  Future<List<Genre>> getGenres() async {
    return api.getGenres();
  }
}
