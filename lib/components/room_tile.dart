import 'package:flutter/material.dart';
import 'package:hotel_manager/constants/colour_constants.dart';
import 'package:hotel_manager/constants/text_constants.dart';

class RoomTile extends StatelessWidget {
  RoomTile({
    required this.roomId,
    required this.roomNo,
    this.color = Colors.transparent,
    this.borderColor = ColourConstants.mainBlue,
    this.textColor = ColourConstants.richBlack,
    this.onPressed,
  });

  int roomId;
  int roomNo;
  Color color;
  Color borderColor;
  Color textColor;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 2),
          color: color,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Center(
          child: Text(
            roomNo.toString(),
            style: TextConstants.subTextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
