import 'package:flutter/material.dart';
import 'package:hotel_manager/components/input_field.dart';
import 'package:hotel_manager/constants/text_constants.dart';

class NamedInputField extends StatelessWidget {
  NamedInputField({
    required this.titleText,
    required this.onChanged,
    this.labelText,
    this.height,
    this.width,
    this.readOnly = false,
    this.initialValue,
    this.titleTextStyle,
  });

  final String titleText;
  final void Function(String? value) onChanged;
  String? labelText;
  double? height;
  double? width;
  String? initialValue;
  bool readOnly;
  TextStyle? titleTextStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
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
          InputField(
            labelText: labelText ?? titleText,
            onChanged: onChanged,
            height: height,
            width: width,
            initialValue: initialValue,
            readOnly: readOnly,
          ),
        ],
      ),
    );
  }
}
