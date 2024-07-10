import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../constants/colour_constants.dart';
import '../constants/svg_constants.dart';
import '../constants/text_constants.dart';

class ReviewTile extends StatelessWidget {
  const ReviewTile({
    required this.customerName,
    required this.reviewDate,
    required this.review,
  });

  final String customerName;
  final DateTime reviewDate;
  final String review;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: ColourConstants.orchidAccent,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.string(
                SvgConstants.customerReviewAvatarImage,
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customerName,
                      style: TextConstants.subTextStyle(fontSize: 24),
                    ),
                    Text(
                      DateFormat('yy/MM/dd').format(reviewDate),
                      style: TextConstants.subTextStyle(
                          fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            review,
            overflow: TextOverflow.visible,
            style: TextConstants.subTextStyle(
                fontSize: 19, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
