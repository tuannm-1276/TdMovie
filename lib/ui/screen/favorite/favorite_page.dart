import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:td_movie/base/base.dart';
import 'package:td_movie/blocs/favorite/blocs.dart';
import 'package:td_movie/domain/model/movie.dart';
import 'package:td_movie/ui/components/common/movie_item.dart';
import 'package:td_movie/ui/components/common/progress_loading.dart';
import 'package:td_movie/ui/components/common/route_to_detail.dart';

import '../../../main.dart';

class FavoriteScreen extends StatelessWidget {
  final FavoriteDataHandle favoriteDataHandle;

  const FavoriteScreen({Key key, this.favoriteDataHandle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteBloc(InitState())..add(GetFavorites()),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          margin: const EdgeInsets.all(12.0),
          child: BlocBuilder<FavoriteBloc, BaseState>(
            builder: (context, state) {
              if (state is LoadedState) {
                final List<Movie> movies = state.data ?? [];
                return movies.isEmpty
                    ? Center(
                        child: Text(
                          'No Favorite Movie.',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : GridView.count(
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 12.0,
                        childAspectRatio: (1 / 2),
                        crossAxisCount: 2,
                        children: List.generate(
                          movies.length,
                          (index) => GestureDetector(
                            child: MovieItem(movie: movies[index]),
                            onTap: () {
                              Navigator.of(context)
                                  .push(
                                    navigateToDetail(movies[index]),
                                  )
                                  .then(
                                    (value){
                                      favoriteDataHandle.update();
                                    }
                                  );
                            },
                          ),
                        ),
                      );
              }
              return Center(
                child: ProgressLoading(size: 32),
              );
            },
          ),
        ),
      ),
    );
  }
}
