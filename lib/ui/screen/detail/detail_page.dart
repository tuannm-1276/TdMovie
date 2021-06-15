import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:td_movie/domain/model/models.dart';
import 'package:td_movie/platform/services/api/urls.dart';
import 'package:td_movie/ui/components/rating_bar_indicator.dart';
import 'package:td_movie/ui/screen/detail/cast_item.dart';
import 'package:td_movie/ui/screen/detail/company_item.dart';
import 'package:td_movie/ui/screen/detail/detail_provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:td_movie/extension//build_context_ext.dart';

class DetailPage extends StatefulWidget {
  DetailPage({@required this.movie});

  final Movie movie;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _detailProvider = DetailProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: SafeArea(
          child: Stack(
            children: [
              // Backdrop Image
              _buildBackdropImage(
                  '${Urls.originalImagePath}${widget.movie.backdropPath}'),
              // Color Filter
              _buildColorFilter(),
              // Content
              _buildContent(widget.movie),
            ],
          ),
        ),
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
    final width = MediaQuery.of(context).size.width * 4.5 / 7;
    final height = MediaQuery.of(context).size.height * 3.5 / 7 - 56;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 12, top: 4, right: 12),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 4,
                  bottom: 8,
                ),
                child: _buildBackButton(),
              ),
            ),
            _buildPosterImage(
              '${Urls.originalImagePath}${movie.posterPath}',
              height: height,
            ),
            SizedBox(height: 8),
            _buildMovieTitle(movie.title, width: width),
            SizedBox(height: 8),
            _buildVoteAverage(movie.voteAverage),
            SizedBox(height: 8),
            _buildVoteRatingBar(movie.voteAverage),
            SizedBox(height: 16),
            _buildCommonInformation(movie),
            SizedBox(height: 16),
            _buildGenres(_detailProvider.getGenres()),
            SizedBox(height: 16),
            _buildOverview(movie.overview),
            SizedBox(height: 16),
            _buildCasts(_detailProvider.getCasts()),
            SizedBox(height: 16),
            _buildProductionCompanies(_detailProvider.getProductionCompanies()),
            SizedBox(height: 16),
          ],
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
      height: height,
      width: height * 2 / 3,
      child: Container(
        foregroundDecoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.black),
          ),
        ),
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildMovieTitle(String title, {double width}) {
    return SizedBox(
      width: width,
      child: Center(
        child: Text(
          widget.movie.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
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
            maxHeight: 150,
          ),
          child: ListView.builder(
            itemCount: casts.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: ClampingScrollPhysics(),
            itemBuilder: (innerContext, index) {
              final cast = casts[index];
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
