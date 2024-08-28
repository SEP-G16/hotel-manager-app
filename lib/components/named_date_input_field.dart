import 'package:flutter/material.dart';
import 'package:hotel_manager/components/date_input_field.dart';

import '../constants/text_constants.dart';

class NamedDateInputField extends StatelessWidget {
  NamedDateInputField({
    required this.titleText,
    required this.onPressed,
    this.selectedDate,
    this.height,
    this.width,
  });

  final String titleText;
  final void Function() onPressed;
  DateTime? selectedDate;
  double? height;
  double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleText,
            style: TextConstants.mainTextStyle(fontSize: 25),
          ),
          SizedBox(
            height: 5,
          ),
          DateInputField(
            onPressed: onPressed,
            selectedDate: selectedDate,
            height: height,
            width: width,
          ),
        ],
      ),
    );
  }
}
