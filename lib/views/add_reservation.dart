import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_manager/components/action_button.dart';
import 'package:hotel_manager/components/custom_drop_down_button.dart';
import 'package:hotel_manager/components/named_date_input_field.dart';
import 'package:hotel_manager/components/named_drop_down_button.dart';
import 'package:hotel_manager/constants/colour_constants.dart';
import 'package:hotel_manager/controllers/view/add_reservation_view_state_controller.dart';
import 'package:intl/intl.dart';

import '../components/named_input_field.dart';
import '../constants/svg_constants.dart';
import '../constants/text_constants.dart';

import 'package:get/get.dart';

class AddReservationScreen extends StatelessWidget {
  AddReservationScreen({super.key}) {
    Get.put(AddReservationViewStateController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColourConstants.ivory,
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
                        onTap: () {},
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
                        'Add Reservation',
                        style: TextConstants.mainTextStyle(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        NamedInputField(titleText: 'Name', onChanged: (value) {}),

                        Obx(
                              () => NamedDateInputField(
                            titleText: 'Check In Date',
                            onPressed: () async {
                              DateTime? selectedDate = await showDatePicker(
                                context: context,
                                firstDate: DateTime(DateTime.now().year - 100),
                                lastDate: DateTime.now(),
                              );
                              if (selectedDate != null) {
                                AddReservationViewStateController
                                    .instance.selectedDate = selectedDate;
                              }
                            },
                            selectedDate: AddReservationViewStateController
                                .instance.selectedDate,
                          ),
                        ),
                        Obx(
                              () => NamedDateInputField(
                            titleText: 'Check Out Date',
                            onPressed: () async {
                              DateTime? selectedDate = await showDatePicker(
                                context: context,
                                firstDate: DateTime(DateTime.now().year - 100),
                                lastDate: DateTime.now(),
                              );
                              if (selectedDate != null) {
                                AddReservationViewStateController
                                    .instance.selectedDate = selectedDate;
                              }
                            },
                            selectedDate: AddReservationViewStateController
                                .instance.selectedDate,
                          ),
                        ),

                        Obx(
                              () => NamedDropDownButton(
                            titleText: 'Rooms',
                            value: AddReservationViewStateController
                                .instance.selectedValue,
                            selectOptionValue: -1,
                            onChanged: (value) {
                              AddReservationViewStateController
                                  .instance.selectedValue = value;
                            },
                            itemList: List.generate(
                              10,
                                  (index) => DropdownMenuItem(
                                child: Text(
                                  '$index',
                                  style: TextConstants.subTextStyle(),
                                ),
                              ),
                            ),
                          ),
                        ),

                        Obx(
                              () => NamedDropDownButton(
                            titleText: 'Room Category',
                            value: AddReservationViewStateController
                                .instance.selectedCategory,
                            selectOptionValue: 'Select',
                            onChanged: (value) {
                              AddReservationViewStateController
                                  .instance.selectedCategory = value;
                            },
                            itemList: ['Standard', 'Deluxe', 'Family']
                                .map<DropdownMenuItem<String>>(
                                  (category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category,
                                  style: TextConstants.subTextStyle(),
                                ),
                              ),
                            )
                                .toList(),
                          ),
                        ),

                        // Obx(
                        //       () => Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjust as needed
                        //     children: [
                        //       Expanded(
                        //         child: NamedDropDownButton(
                        //           titleText: 'Adults',
                        //           value: AddReservationViewStateController.instance.selectedValue,
                        //           selectOptionValue: -1,
                        //           onChanged: (value) {
                        //             AddReservationViewStateController.instance.selectedValue = value;
                        //           },
                        //           itemList: List.generate(
                        //             10,
                        //                 (index) => DropdownMenuItem(
                        //               value: index,
                        //               child: Text(
                        //                 '$index',
                        //                 style: TextConstants.subTextStyle(),
                        //               ),
                        //             ),
                        //           )
                        //         ),
                        //       ),
                        //       SizedBox(width: 7), // Space between the dropdowns
                        //       Expanded(
                        //         child: NamedDropDownButton(
                        //           titleText: 'Children',
                        //           value: AddReservationViewStateController.instance.selectedValue,
                        //           selectOptionValue: -1,
                        //           onChanged: (value) {
                        //             AddReservationViewStateController.instance.selectedValue = value;
                        //           },
                        //           itemList: List.generate(
                        //             10,
                        //                 (index) => DropdownMenuItem(
                        //               value: index,
                        //               child: Text(
                        //                 '$index',
                        //                 style: TextConstants.subTextStyle(),
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        //

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child:
                          ActionButton(btnText: 'Add', onTap: () {}),
                        ),
                      ],
                    ),
                  )
              )
            ],
          ),
        )
    );
    throw UnimplementedError();
  }




  }