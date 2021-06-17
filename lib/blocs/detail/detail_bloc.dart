import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sealed_class/sealed_class.dart';
import 'package:td_movie/domain/model/models.dart';
import 'package:td_movie/platform/repositories/movie_repository.dart';

part 'detail_event.dart';

part 'detail_state.dart';

part 'detail_bloc.g.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final MovieRepository movieRepository;

  DetailBloc({@required this.movieRepository}) : super(DetailLoadInProgress());

  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async* {
    switch (event.runtimeType) {
      case DetailLoaded:
        yield* _mapDetailLoadedToState((event as DetailLoaded).id);
    }
  }

  Stream<DetailState> _mapDetailLoadedToState(int id) async* {
    try {
      final movie = await movieRepository.getMovieDetail(id);
      final casts = await movieRepository.getMovieCredits(id);
      yield DetailLoadSuccess(movie, casts);
    } catch (error) {
      yield DetailLoadFailure(error);
    }
  }
}
