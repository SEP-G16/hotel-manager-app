import 'package:flutter/material.dart';
import 'package:hotel_manager/components/action_button.dart';
import 'package:hotel_manager/constants/colour_constants.dart';

import '../../constants/text_constants.dart';
import 'package:get/get.dart';

class AssignRoomsScreen extends StatelessWidget {
  const AssignRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColourConstants.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: ColourConstants.mainBlue,
                        size: 30,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Select Rooms',
                      style: TextConstants.mainTextStyle(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  //based on room count
                  Text(
                    'Select ${3} rooms',
                    style: TextConstants.subTextStyle(fontSize: 22),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    5,
                    (index) => Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ColourConstants.mainBlue, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          color: ColourConstants.white),
                      padding: EdgeInsets.all(10.0),
                      margin: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Room - 10${index}',
                            style: TextConstants.subTextStyle(),
                          ),
                          Transform.scale(
                            scale: 1.2,
                            child: Checkbox(
                              value: true,
                              onChanged: (value) {},
                              shape: CircleBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: ActionButton(
                btnText: 'Done',
                onTap: () {
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
