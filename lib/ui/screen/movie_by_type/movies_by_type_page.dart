import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:td_movie/blocs/blocs.dart';
import 'package:td_movie/blocs/movies_by_type/movies_by_type_bloc.dart';
import 'package:td_movie/di/injection.dart';
import 'package:td_movie/domain/model/models.dart';
import 'package:td_movie/platform/repositories/movie_repository.dart';
import 'package:td_movie/ui/components/common/bottom_loader.dart';
import 'package:td_movie/ui/components/common/movie_item.dart';
import 'package:td_movie/ui/screen/detail/detail_page.dart';

class MoviesByTypePage extends StatefulWidget {
  MoviesByTypePage({Key key, this.type}) : super(key: key);

  final String type;

  @override
  _MoviesByTypePageState createState() => _MoviesByTypePageState();
}

class _MoviesByTypePageState extends State<MoviesByTypePage> {
  final _scrollController = ScrollController();
  MoviesByTypeBloc _moviesBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // _moviesBloc = BlocProvider.of<MoviesByTypeBloc>(context);
    _moviesBloc = context.read<MoviesByTypeBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.type),
        backgroundColor: Colors.black,
      ),
      body: BlocBuilder<MoviesByTypeBloc, MoviesByTypeState>(
          builder: (context, state) {
        switch (state.status) {
          case MovieListStatus.success:
            if (state.movies.isEmpty) {
              return Center(child: Text('No Movies'));
            }
            final width = (MediaQuery.of(context).size.width / 2) - 16;
            return Padding(
              padding: EdgeInsets.only(left: 0),
              child: GridView.builder(
                controller: _scrollController,
                itemCount: state.isEndReached
                    ? state.movies.length
                    : state.movies.length + 1,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: width * 2,
                ),
                itemBuilder: (context, index) {
                  return index >= state.movies.length
                      ? BottomLoader()
                      : InkWell(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: MovieItem(
                              movie: state.movies[index],
                            ),
                          ),
                          onTap: () => _navigateToDetail(state.movies[index]),
                        );
                },
              ),
            );
          case MovieListStatus.failure:
            return Container(
              color: Colors.black,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 80.0,
                    ),
                    SizedBox(height: 16.0),
                    Text('Error'),
                  ],
                ),
              ),
            );
          default:
            return Container(
              color: Colors.black,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16.0),
                    Text(
                      'Loading at the moment, please hold the line.',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
        }
      }),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) _moviesBloc.add(MovieListFetched(widget.type));
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _navigateToDetail(Movie movie) {
    final detailPage = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
        create: (context) {
          return DetailBloc(movieRepository: getIt.get<MovieRepository>())
            ..add(DetailLoaded(movie.id));
        },
        child: DetailPage(),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = Offset(1.0, 0.0);
        final end = Offset.zero;
        final curveTween = CurveTween(curve: Curves.ease);
        final tween = Tween(begin: begin, end: end).chain(curveTween);
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
    Navigator.of(context).push(detailPage);
  }
}
