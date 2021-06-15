import 'package:flutter/material.dart';
import 'package:td_movie/domain/model/models.dart';
import 'package:td_movie/platform/services/api/urls.dart';
import 'package:transparent_image/transparent_image.dart';

class CompanyItem extends StatelessWidget {
  const CompanyItem({
    Key key,
    @required this.company,
  }) : super(key: key);

  final ProductionCompany company;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              height: 60,
              color: Colors.white,
              foregroundDecoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Colors.white),
                ),
              ),
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: '${Urls.originalImagePath}${company.logoPath}',
                fit: BoxFit.cover,
              )),
          SizedBox(height: 8),
          Text(
            company.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
