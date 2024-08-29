import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_manager/components/action_button.dart';
import 'package:hotel_manager/components/named_date_input_field.dart';
import 'package:hotel_manager/components/named_drop_down_button.dart';
import 'package:hotel_manager/components/named_input_field.dart';
import 'package:hotel_manager/constants/colour_constants.dart';
import 'package:hotel_manager/constants/text_constants.dart';
import 'package:hotel_manager/controllers/view/add_booking_view_state_controller.dart';
import 'package:hotel_manager/enum/room_type.dart';

import '../../controllers/view/booking_tab_controller.dart';

class AddBookingScreen extends StatelessWidget {
  AddBookingScreen({super.key}) {
    Get.put(AddBookingViewStateController());
    Get.put(BookingTabController());
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
                      'Add Booking',
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: NamedInputField(
                        width: double.maxFinite,
                        titleText: 'Name',
                        onChanged: (value) {
                          AddBookingViewStateController.instance.name = value!;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: NamedInputField(
                        width: double.maxFinite,
                        titleText: 'Phone No.',
                        onChanged: (value) {},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: NamedInputField(
                        width: double.maxFinite,
                        titleText: 'Email',
                        onChanged: (value) {},
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: NamedInputField(
                              titleTextStyle:
                                  TextConstants.mainTextStyle(fontSize: 18),
                              titleText: 'Adult Count',
                              initialValue: 0.toString(),
                              onChanged: (value) {},
                            ),
                          ),
                          Expanded(
                            child: NamedInputField(
                              titleTextStyle:
                                  TextConstants.mainTextStyle(fontSize: 18),
                              titleText: 'Children Count',
                              initialValue: 0.toString(),
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Obx(
                        () => NamedDropDownButton(
                          width: double.maxFinite,
                          titleText: 'Room Category',
                          value: AddBookingViewStateController
                              .instance.selectedCategory,
                          selectOptionValue: 'Select',
                          onChanged: (value) {
                            AddBookingViewStateController
                                .instance.selectedCategory = value;
                          },
                          itemList: RoomType.values
                              .map<DropdownMenuItem<String>>(
                                (category) => DropdownMenuItem(
                                  value: category.getRoomTypeAsString(),
                                  child: Text(
                                    category.getRoomTypeAsString(),
                                    style: TextConstants.subTextStyle(),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: NamedInputField(
                        width: double.maxFinite,
                        titleText: 'Room Count',
                        initialValue: 0.toString(),
                        onChanged: (value) {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Obx(
                        () => NamedDateInputField(
                          width: double.maxFinite,
                          titleText: 'Check In Date',
                          onPressed: () async {
                            DateTime? selectedDate = await showDatePicker(
                              context: context,
                              firstDate: DateTime(DateTime.now().year - 100),
                              lastDate: DateTime.now(),
                            );
                            if (selectedDate != null) {
                              AddBookingViewStateController
                                  .instance.selectedDate = selectedDate;
                            }
                          },
                          selectedDate: AddBookingViewStateController
                              .instance.selectedDate,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Obx(
                        () => NamedDateInputField(
                          width: double.maxFinite,
                          titleText: 'Check Out Date',
                          onPressed: () async {
                            DateTime? selectedDate = await showDatePicker(
                              context: context,
                              firstDate: DateTime(DateTime.now().year - 100),
                              lastDate: DateTime.now(),
                            );
                            if (selectedDate != null) {
                              AddBookingViewStateController
                                  .instance.checkOutDate = selectedDate;
                            }
                          },
                          selectedDate: AddBookingViewStateController
                              .instance.checkOutDate,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ActionButton(
                        btnText: 'Check Availability',
                        outlineMode: true,
                        borderColour: ColourConstants.mainBlue,
                        borderWidth: 2.0,
                        onTap: () {},
                        width: 250,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ActionButton(
                        btnText: 'Assign Rooms',
                        outlineMode: true,
                        borderColour: ColourConstants.green1,
                        borderWidth: 2.0,
                        width: 250,
                        onTap: () {
                          //Navigate back to view all bookings <- show in sorted order by date
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ActionButton(
                        btnText: 'Cancel',
                        outlineMode: true,
                        borderColour: ColourConstants.red1,
                        borderWidth: 2.0,
                        width: 250,
                        onTap: () {
                          //Navigate back to view all bookings <- show in sorted order by date
                        },
                      ),
                    ),
                    SizedBox(height: 20.0,),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
