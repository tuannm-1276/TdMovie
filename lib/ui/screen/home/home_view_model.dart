import 'package:td_movie/domain/model/models.dart';

class HomeViewModel {
  HomeViewModel({this.headerTitle, this.items});

  final String headerTitle;
  final List<Movie> items;
}
