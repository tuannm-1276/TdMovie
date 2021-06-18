
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:td_movie/domain/model/genre.dart';
import 'package:td_movie/platform/repositories/genres_repository.dart';

part 'genres_event.dart';

part 'genres_state.dart';

part 'genres_bloc.g.dart';

class GenresBloc extends Bloc<GenresEvent, GenresState> {
  final GenresRepository genresRepository;

  GenresBloc({@required this.genresRepository}) : super(GenresLoadInProgress());

  @override
  Stream<GenresState> mapEventToState(GenresEvent event) async* {
    switch (event.runtimeType) {
      case GenresLoaded:
        yield* _mapGenresLoadedToState();
    }
  }

  Stream<GenresState> _mapGenresLoadedToState() async* {
    try {
      final data = await genresRepository.getGenres();
      yield GenresLoadSuccess(data);
    } catch (error) {
      yield GenresLoadFailure(error);
    }
  }
}
