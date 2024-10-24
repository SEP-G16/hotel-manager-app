import 'package:flutter/material.dart';

import '../constants/colour_constants.dart';
import '../constants/text_constants.dart';

class CustomDropDownButton<T> extends StatelessWidget {
  CustomDropDownButton({required this.value, this.itemList, required this.selectOptionValue, required this.onChanged, this.includeSelectOption = true});

  T value;
  T selectOptionValue;
  bool includeSelectOption;
  List<DropdownMenuItem<T>>? itemList;
  void Function(T? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
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
      child: DropdownButton(
        style: TextConstants.subTextStyle(),
        underline: Container(),
        value: value,
        items: (includeSelectOption ? <DropdownMenuItem<T>>[
          DropdownMenuItem<T>(
            value: selectOptionValue,
            child: Container(
              child: Text(
                'Select',
                style: TextConstants.subTextStyle(),
              ),
            ),
          ),
        ] : <DropdownMenuItem<T>>[]) +
            (itemList ?? []),
        onChanged: onChanged,
        isExpanded : true,
      ),
    );
  }
}
