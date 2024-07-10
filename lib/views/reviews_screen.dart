import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_manager/components/review_tile.dart';
import 'package:hotel_manager/constants/svg_constants.dart';

import '../constants/colour_constants.dart';
import '../constants/text_constants.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColourConstants.ivory,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: ColourConstants.mainBlue,
                        size: 30,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Customer Reviews',
                      style: TextConstants.mainTextStyle(),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ReviewTile(
                      customerName: 'Sarah L.',
                      reviewDate: DateTime(2024, 5, 11),
                      review:
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In tortor erat, malesuada ut vulputate molestie, tincidunt ut turpis. Suspendisse commodo tincidunt lorem ut eleifend. Ut convallis enim nisl, nec commodo velit pellentesque eu. Nulla scelerisque ipsum ligula, ut feugiat tellus pretium bibendum. Mauris luctus rhoncus erat in semper.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
