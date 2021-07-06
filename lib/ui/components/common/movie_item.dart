import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:td_movie/domain/model/models.dart';
import 'package:td_movie/platform/services/api/urls.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({
    Key key,
    @required this.movie,
    this.height,
    this.width,
  }) : super(key: key);

  final Movie movie;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: width * 3,
      child: Wrap(
        children: [
          SizedBox(
            height: width * 1.5,
            width: width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                '${Urls.w500ImagePath}${movie.posterPath}',
                fit: BoxFit.cover,
                width: width,
                height: width * 1.5,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 8,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Center(
                    child: Text(
                      movie.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      Text(
                        '(${getYearOfMovie(movie)})',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Text(
                        '${movie.voteAverage}',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String getYearOfMovie(Movie movie) {
  if (movie.releaseDate == null) {
    return 'Unknown';
  }
  return movie.releaseDate.isEmpty
      ? 'Unknown'
      : movie.releaseDate.substring(0, 4);
}
