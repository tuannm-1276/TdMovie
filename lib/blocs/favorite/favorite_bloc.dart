import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:td_movie/base/base.dart';
import 'package:td_movie/blocs/favorite/blocs.dart';
import 'package:td_movie/di/injection.dart';
import 'package:td_movie/platform/repositories/favorite_repository.dart';

class FavoriteBloc extends Bloc<BaseEvent, BaseState> {
  final FavoriteRepository repository = getIt.get<FavoriteRepository>();

  FavoriteBloc(BaseState initialState) : super(initialState);

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is ClickedFavorite) {
      try {
        yield (LoadingState());
        final result = await repository.isFavorite(event.movie);
        if (result == true) {
          await repository.deleteFavorite(event.movie);
          print('UN FAVORITE');
          yield (NormalState());
        } else if (result == false) {
          await repository.addFavorite(event.movie);
          print('FAVORITE');
          yield (FavoriteState());
        }
      } catch (e) {
        yield (ErrorState(data: e.toString()));
      }
    } else if (event is CheckFavorite) {
      try {
        yield (LoadingState());
        final result = await repository.isFavorite(event.movie);
        yield (result == true ? FavoriteState() : NormalState());
      } catch (e) {
        yield (ErrorState(data: e.toString()));
      }
    } else if (event is GetFavorites) {
      try {
        yield (LoadingState());
        final result = await repository.getFavorites();
        yield (LoadedState(data: result));
      } catch (e) {
        yield (ErrorState(data: e.toString()));
      }
    } else if (event is UnFavorite) {
      try {
        await repository.deleteFavorite(event.movie);
      } catch (e) {
        yield (ErrorState(data: e.toString()));
      }
    }
  }
}
