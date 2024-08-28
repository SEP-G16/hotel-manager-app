import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_manager/views/temp_reservation_details.dart';

import '../constants/colour_constants.dart';
import '../constants/text_constants.dart';
import '../controllers/view/booking_tab_controller.dart'; // Import the details screen

class BookingTile extends StatelessWidget {
  final Room room;
  double? width;
  double? height;
  final VoidCallback onPressed;

  BookingTile({
    required this.room,
    this.width,
    this.height,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;

    return Container(
      height: height ?? screenHeight * 0.1,
      margin: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      padding: EdgeInsets.all(screenHeight * 0.02),
      decoration: BoxDecoration(
        color: ColourConstants.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 4,
          ),
        ],
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              room.number,
              style: TextConstants.mainTextStyle(
                fontSize: screenHeight * 0.025,
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 0,
            bottom: 0,
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  foregroundColor: ColourConstants.white,
                  backgroundColor: ColourConstants.mainBlue,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(8.0),
                  elevation: 8.0,
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: screenHeight * 0.03,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
