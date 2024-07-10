import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/colour_constants.dart';
import '../constants/text_constants.dart';

class DateInputField extends StatelessWidget {
  DateInputField({
    this.selectedDate,
    required this.onPressed,
    this.height,
    this.width,
  });

  DateTime? selectedDate;
  final void Function() onPressed;
  double? height;
  double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      width: width ?? 300,
      height: height ?? 60,
      decoration: BoxDecoration(
        color: ColourConstants.orchidAccent,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat('yyyy/MM/dd').format(
              selectedDate ?? DateTime.now(),
            ),
            style: TextConstants.subTextStyle(),
          ),
          GestureDetector(
            onTap: onPressed,
            child: Icon(
              Icons.calendar_month,
              color: ColourConstants.richBlack,
            ),
          ),
        ],
      ),
    );
  }
}
