import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:td_movie/base/base_state.dart';
import 'package:td_movie/blocs/detail/detail_bloc.dart';
import 'package:td_movie/blocs/favorite/favorite_bloc.dart';
import 'package:td_movie/di/injection.dart';
import 'package:td_movie/domain/model/movie.dart';
import 'package:td_movie/platform/repositories/movie_repository.dart';
import 'package:td_movie/ui/screen/detail/detail_page.dart';

Route navigateToDetail(Movie movie) {
  return PageRouteBuilder(
    pageBuilder: (
      context,
      animation,
      secondaryAnimation,
    ) => MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return DetailBloc(movieRepository: getIt.get<MovieRepository>())
              ..add(DetailLoaded(movie.id));
          },
        ),
        BlocProvider(
          create: (context) => FavoriteBloc(InitState()),
        ),
      ],
      child: DetailPage(),
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return buildCommonTransitions(
          context, animation, secondaryAnimation, child);
    },
  );
}

Widget buildCommonTransitions(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  final begin = Offset(1.0, 0.0);
  final end = Offset.zero;
  final curveTween = CurveTween(curve: Curves.ease);
  final tween = Tween(begin: begin, end: end).chain(curveTween);
  return SlideTransition(
    position: animation.drive(tween),
    child: child,
  );
}
