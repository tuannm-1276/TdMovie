import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:td_movie/blocs/blocs.dart';
import 'package:td_movie/domain/model/models.dart';
import 'package:td_movie/platform/services/api/urls.dart';
import 'package:td_movie/ui/components/rating_bar_indicator.dart';
import 'package:td_movie/ui/components/collapsed_appbar_title.dart';
import 'package:td_movie/ui/screen/detail/cast_item.dart';
import 'package:td_movie/ui/screen/detail/company_item.dart';
import 'package:td_movie/extension//build_context_ext.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          return state.switchResult(
            onDetailLoadSuccess: (successState) {
              final movie =
                  successState.movie.copyWith(credits: successState.credits);
              return Container(
                color: Colors.black,
                child: SafeArea(
                  child: Stack(
                    children: [
                      // Backdrop Image
                      _buildBackdropImage(
                          '${Urls.originalImagePath}${movie.backdropPath}'),
                      // Color Filter
                      _buildColorFilter(),
                      // Content
                      _buildContent(movie),
                    ],
                  ),
                ),
              );
            },
            onDetailLoadFailure: (failState) {
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
                      Text('${failState.error.toString()}'),
                    ],
                  ),
                ),
              );
            },
            onDetailLoadInProgress: (loadingState) {
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
            },
          );
        },
      ),
    );
  }

  Widget _buildBackdropImage(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(imagePath),
        ),
      ),
    );
  }

  Widget _buildColorFilter() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: List<double>.generate(
            15,
            (index) => (index + 3) / 10,
          )
              .map((e) => e < 1 ? Colors.black.withOpacity(e) : Colors.black)
              .toList(),
        ),
      ),
    );
  }

  Widget _buildContent(Movie movie) {
    final height = MediaQuery.of(context).size.height * 3.5 / 7 - 56;
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            backgroundColor: Colors.black,
            expandedHeight: height * 1.5,
            floating: false,
            pinned: true,
            leading: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 4,
                  left: 8,
                  bottom: 8,
                ),
                child: _buildBackButton(),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: CollapsedAppBarTitle(child: Text(movie.title)),
              background: Stack(
                children: [
                  _buildBackdropImage(
                      '${Urls.originalImagePath}${movie.backdropPath}'),
                  _buildColorFilter(),
                  Center(
                    child: _buildPosterImage(
                      '${Urls.originalImagePath}${movie.posterPath}',
                      height: height,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ];
      },
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 12, right: 12),
          child: Column(
            children: [
              _buildMovieTitle(movie.title),
              SizedBox(
                height: 8,
              ),
              _buildVoteAverage(movie.voteAverage),
              SizedBox(height: 8),
              _buildVoteRatingBar(movie.voteAverage),
              SizedBox(height: 16),
              _buildCommonInformation(movie),
              SizedBox(height: 16),
              _buildGenres(movie.genres),
              SizedBox(height: 16),
              _buildOverview(movie.overview),
              SizedBox(height: 16),
              _buildCasts(movie.credits.casts),
              SizedBox(height: 16),
              _buildProductionCompanies(movie.productionCompanies),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return SizedBox(
      width: 40,
      height: 40,
      child: Container(
        foregroundDecoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.white),
          ),
        ),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  Widget _buildPosterImage(String imagePath, {double height}) {
    return SizedBox(
      height: height * 1.4,
      width: height * 1.2 * 2 / 3,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imagePath),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: Colors.transparent,
        ),
        foregroundDecoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildMovieTitle(String title) {
    return Center(
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildVoteAverage(double voteAverage) {
    return Text(
      '$voteAverage',
      style: TextStyle(
        color: Colors.amberAccent,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildVoteRatingBar(double voteAverage) {
    return RatingBarIndicator(
      rating: voteAverage / 2,
      unratedColor: Colors.amber,
      itemCount: 5,
      itemSize: 20,
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      unratedItemBuilder: (context, index) => Icon(
        Icons.star_border_outlined,
        color: Colors.amber,
      ),
    );
  }

  Widget _buildGenres(List<Genre> genres) {
    return SizedBox(
      height: 36,
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: ActionChip(
            label: Text(genres[index].name),
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
            backgroundColor: Colors.black.withOpacity(0.9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.white),
            ),
            onPressed: () {
              final snackBar = SnackBar(
                content: Text(genres[index].name),
                duration: const Duration(milliseconds: 500),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCommonInformation(Movie movie) {
    print('Movie id: ${movie.id}');
    return Table(
      defaultColumnWidth: FlexColumnWidth(),
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      children: [
        TableRow(
          children: [
            TableCell(
              child: Text(
                'Length',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            TableCell(
              child: Text(
                'Language',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            TableCell(
              child: Text(
                'Year',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            TableCell(
              child: Text(
                'Vote Count',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                movie.runtime.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                // '${movie.spokenLanguages?.map((e) => e.englishName + ", ")}',
                'English, Japanese, Spanish, Indian',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                movie.releaseDate.year.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                movie.voteCount.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOverview(String overview) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Overview',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: ExpandableText(
            overview,
            expandText: 'Show More',
            maxLines: 3,
            expandOnTextTap: true,
            collapseOnTextTap: true,
            linkColor: Colors.blue,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCasts(List<Cast> casts) {
    final data = casts ?? [];
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Cast',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 8),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 200,
          ),
          child: ListView.builder(
            itemCount: data.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: ClampingScrollPhysics(),
            itemBuilder: (innerContext, index) {
              final cast = data[index];
              return InkWell(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: CastItem(cast: cast),
                ),
                onTap: () {
                  final snackBar = SnackBar(
                    content: Text(cast.name),
                    duration: const Duration(milliseconds: 500),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductionCompanies(List<ProductionCompany> companies) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Production Companies',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 8),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 100,
          ),
          child: ListView.builder(
            itemCount: companies.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: ClampingScrollPhysics(),
            itemBuilder: (innerContext, index) {
              final company = companies[index];
              return InkWell(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: CompanyItem(company: company),
                ),
                onTap: () {
                  context.showSnackBar(
                    Text(company.name),
                    Duration(milliseconds: 500),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
