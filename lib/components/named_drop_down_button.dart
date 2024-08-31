import 'package:flutter/material.dart';

import '../constants/text_constants.dart';
import 'custom_drop_down_button.dart';

class NamedDropDownButton<T> extends StatelessWidget {
  NamedDropDownButton({
    required this.titleText,
    required this.value,
    required this.selectOptionValue,
    required this.onChanged,
    this.itemList,
    this.width,
    this.titleTextStyle,
  });

  final String titleText;
  dynamic value;
  dynamic selectOptionValue;
  void Function(T? value)? onChanged;
  List<DropdownMenuItem<T>>? itemList;
  double? width;
  TextStyle? titleTextStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 300,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleText,
            style: titleTextStyle ?? TextConstants.mainTextStyle(fontSize: 25),
          ),
          SizedBox(
            height: 5.0,
          ),
          CustomDropDownButton<T>(
            value: value,
            selectOptionValue: selectOptionValue,
            onChanged: onChanged,
            itemList: itemList,
          ),
        ],
      ),
    );
  }
}
