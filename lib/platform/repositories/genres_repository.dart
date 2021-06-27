
import 'package:flutter/material.dart';

import '../../domain/model/genre.dart';
import '../services/api/api.dart';

class GenresRepository{
  GenresRepository({@required this.api});

  final Api api;

  Future<List<Genre>> getGenres() {
    return api.getGenres();
  }
}
