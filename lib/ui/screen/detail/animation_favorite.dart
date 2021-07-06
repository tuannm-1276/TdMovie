import 'package:flutter/material.dart';
import 'package:td_movie/base/base.dart';
import 'package:td_movie/blocs/favorite/blocs.dart';
import 'package:td_movie/domain/model/movie.dart';

class FavoriteButton extends StatefulWidget {
  final FavoriteBloc bloc;
  final BaseState state;
  final Movie movie;

  const FavoriteButton({
    Key key,
    this.bloc,
    this.state,
    this.movie,
  }) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _pulseAnimation.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _pulseAnimation,
      child: Container(
        child: InkWell(
          onTap: () {
            _animationController.forward();
            widget.bloc.add(ClickedFavorite(widget.movie));
          },
          child: _getFavoriteIconWithState(widget.state),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

Widget _getFavoriteIconWithState(BaseState state) {
  return state is FavoriteState
      ? Icon(
          Icons.favorite,
          color: Colors.pinkAccent,
        )
      : Icon(
          Icons.favorite,
          color: Colors.white,
        );
}
