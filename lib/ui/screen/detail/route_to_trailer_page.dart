import 'package:flutter/material.dart';
import 'package:td_movie/domain/model/models.dart';
import 'package:td_movie/ui/components/common/route_to_detail.dart';
import 'package:td_movie/ui/screen/detail/trailer_page.dart';

Route navigateToTrailerPage(List<Video> videos) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 1000),
    reverseTransitionDuration: Duration(milliseconds: 1000),
    pageBuilder: (
      context,
      animation,
      secondaryAnimation,
    ) {
      return Container(
        color: Colors.black,
        child: TrailerPage(videos: videos),
      );
    },
    transitionsBuilder: (
      context,
      animation,
      secondaryAnimation,
      child,
    ) => buildCommonTransitions(
      context,
      animation,
      secondaryAnimation,
      child,
    ),
  );
}
