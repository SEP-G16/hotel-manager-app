import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hotel_manager/constants/text_constants.dart';

import 'action_button.dart';

class MessageDialogBox {
  final String message;
  void Function()? onTap;

  MessageDialogBox({required this.message, this.onTap}) {
    _showDialog();
  }

  void _showDialog() {
    Get.dialog(
      Dialog(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                style: TextConstants.subTextStyle(),
              ),
              SizedBox(
                height: 20,
              ),
              ActionButton(
                btnText: 'OK',
                onTap: onTap ?? () {
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
