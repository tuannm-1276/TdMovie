import 'dart:math';

import 'package:flutter/material.dart';
import 'package:td_movie/domain/model/models.dart';
import 'package:td_movie/domain/model/video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerPage extends StatelessWidget {
  final List<Video> videos;

  const TrailerPage({Key key, this.videos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: _getKey(videos),
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        loop: true,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: YoutubePlayerBuilder(
          player: YoutubePlayer(
            showVideoProgressIndicator: true,
            controller: _controller,
            progressColors: ProgressBarColors(
              playedColor: Colors.red,
              handleColor: Colors.redAccent,
            ),
            onReady: () {
              //maybe add listeners
            },
          ),
          builder: (context, player) {
            return player;
          },
        ),
      ),
    );
  }
}

String _getKey(List<Video> videos) {
  if(videos.length == 1){
    return videos[0].key;
  }
  final _random = new Random();
  int index = _random.nextInt(videos.length - 1);
  return videos[index].key;
}
