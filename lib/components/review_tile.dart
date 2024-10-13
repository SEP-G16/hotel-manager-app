import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_manager/components/action_button.dart';
import 'package:hotel_manager/enum/review_status.dart';
import 'package:intl/intl.dart';

import '../constants/colour_constants.dart';
import '../constants/svg_constants.dart';
import '../constants/text_constants.dart';
import '../models/review.dart';

class ReviewTile extends StatelessWidget {
  ReviewTile({
    required this.review,
    this.onAcceptTap,
    this.onAcceptErrorCallBack,
    this.onRejectTap,
    this.onRejectErrorCallBack,
  }) {
    assert(review.status == ReviewStatus.Pending
        ? onAcceptTap != null && onRejectTap != null
        : true);
  }

  final Review review;
  FutureOr<void> Function()? onRejectTap;
  FutureOr<void> Function(Object e)? onRejectErrorCallBack;
  FutureOr<void> Function()? onAcceptTap;
  FutureOr<void> Function(Object e)? onAcceptErrorCallBack;

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
                    LimitedBox(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                      child: Row(
                        children: [
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                review.name,
                                style: TextConstants.subTextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      DateFormat('yy/MM/dd').format(review.createdAt),
                      style: TextConstants.subTextStyle(
                          fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    review.feedback,
                    overflow: TextOverflow.visible,
                    style: TextConstants.subTextStyle(
                        fontSize: 19, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Visibility(
            visible: review.status == ReviewStatus.Pending,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ActionButton(
                  btnText: 'Reject',
                  onTap: () async {
                    try {
                      await onRejectTap!();
                    } catch (e) {
                      if (onRejectErrorCallBack != null) {
                        onRejectErrorCallBack!(e);
                      }
                    }
                  },
                  outlineMode: true,
                  borderWidth: 2.0,
                  borderColour: ColourConstants.red1,
                  height: 50,
                ),
                ActionButton(
                  btnText: 'Accept',
                  onTap: () async {
                    try {
                      await onAcceptTap!();
                    } catch (e) {
                      if (onAcceptErrorCallBack != null) {
                        onAcceptErrorCallBack!(e);
                      }
                    }
                  },
                  outlineMode: true,
                  borderWidth: 2.0,
                  borderColour: ColourConstants.green1,
                  height: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
