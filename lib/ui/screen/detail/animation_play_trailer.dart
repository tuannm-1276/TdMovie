import 'package:flutter/material.dart';
import 'package:td_movie/domain/model/movie.dart';
import 'package:td_movie/domain/model/video.dart';
import 'package:td_movie/ui/screen/detail/route_to_trailer_page.dart';

class PlayButton extends StatefulWidget {
  final Movie movie;

  const PlayButton({Key key, this.movie}) : super(key: key);

  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 4),
      lowerBound: 0.5,
      vsync: this,
    )..forward();
  }

  @override
  Widget build(BuildContext context) {
    final videos = widget.movie.videoList?.videos ?? [];
    return AnimatedBuilder(
      animation:
          CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            _buildContainer(150 * _controller.value),
            _buildContainer(200 * _controller.value),
            _buildContainer(250 * _controller.value),
            _buildContainer(300 * _controller.value),
            _buildContainer(350 * _controller.value),
            _buildButton(videos),
          ],
        );
      },
    );
  }

  Widget _buildButton(List<Video> videos) {
    return videos.isNotEmpty
        ? Center(
            child: InkWell(
              onTap: () {
                _controller.reset();
                _controller.forward();
                Navigator.of(context).push(navigateToTrailerPage(videos));
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  Icons.play_circle_outline,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
          )
        : Center(child: SizedBox.shrink());
  }

  Widget _buildContainer(double radius) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white10.withOpacity(1 - _controller.value),
      ),
    );
  }
}
