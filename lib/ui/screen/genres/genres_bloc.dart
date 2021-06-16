import 'dart:async';

import 'package:td_movie/base/base_bloc.dart';
import 'package:td_movie/base/base_event.dart';
import 'package:td_movie/platform/repositories/genres_repository.dart';

import '../../../domain/model/genre.dart';
import '../../../domain/model/models.dart';

class GenresBloc extends BaseBloc {

  StreamController<List<Genre>> _genresStreamController =
      StreamController<List<Genre>>();

  Stream<List<Genre>> get genresStream => _genresStreamController.stream;

  final GenresRepository repository;

  GenresBloc({this.repository});

  @override
  void handleEvent(BaseEvent event) {
    // TODO: receive events from view and handle
  }

  getGenres() async {
    List<Genre> genres = await repository.getGenres();

    if (genres == null) {
      return;
    }

    // Send data to view
    _genresStreamController.sink.add(genres);
  }

  @override
  void dispose() {
    super.dispose();

    // Close controller this BLoC
    _genresStreamController.close();
  }
}
