import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sealed_class/sealed_class.dart';
import 'package:td_movie/platform/repositories/movie_repository.dart';
import 'package:meta/meta.dart';
import 'package:td_movie/ui/screen/home/home_view_model.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.g.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MovieRepository movieRepository;

  HomeBloc({@required this.movieRepository}) : super(HomeLoadInProgress());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    switch (event.runtimeType) {
      case HomeLoaded:
        yield* _mapHomeLoadedToState();
    }
  }

  Stream<HomeState> _mapHomeLoadedToState() async* {
    try {
      final data = await movieRepository.getHomeMovies();
      yield HomeLoadSuccess(data);
    } catch (error) {
      yield HomeLoadFailure(error);
    }
  }
}
