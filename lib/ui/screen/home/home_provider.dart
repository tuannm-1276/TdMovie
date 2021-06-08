import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:td_movie/platform/services/api/response/movie_list.dart';

import 'home_view_model.dart';

class HomeProvider {
  Future<HomeViewModel> getNowPlaying(String headerTitle) async {
    final jsonString =
        await rootBundle.loadString('assets/json/sample_movies.json');
    Map<String, dynamic> result = jsonDecode(jsonString);
    final movies = MovieList.fromJson(result).movies;
    return HomeViewModel(headerTitle: headerTitle, items: movies);
  }

  Future<List<HomeViewModel>> getData() async {
    return await Future.wait([
      getNowPlaying('Now Playing'),
      getNowPlaying('Popular'),
      getNowPlaying('Top rated'),
      getNowPlaying('Something'),
    ]);
  }
}
