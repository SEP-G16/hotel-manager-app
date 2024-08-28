import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_manager/components/action_button.dart';
import 'package:hotel_manager/components/named_date_input_field.dart';
import 'package:hotel_manager/components/named_drop_down_button.dart';
import 'package:hotel_manager/components/named_input_field.dart';
import 'package:hotel_manager/constants/colour_constants.dart';
import 'package:hotel_manager/constants/text_constants.dart';
import 'package:hotel_manager/controllers/view/add_reservation_view_state_controller.dart';
import 'package:hotel_manager/views/booking_tab_screen.dart';

import '../controllers/view/booking_tab_controller.dart';

class AddReservationScreen extends StatelessWidget {
  AddReservationScreen({super.key}) {
    Get.put(AddReservationViewStateController());
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: NamedInputField(
                        width: double.maxFinite,
                        titleText: 'Name',
                        onChanged: (value) {
                          AddReservationViewStateController.instance.name =
                              value!;
                        },
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
                              AddReservationViewStateController
                                  .instance.selectedDate = selectedDate;
                            }
                          },
                          selectedDate: AddReservationViewStateController
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
                              AddReservationViewStateController
                                  .instance.checkOutDate = selectedDate;
                            }
                          },
                          selectedDate: AddReservationViewStateController
                              .instance.checkOutDate,
                        ),
                      ),
                    ),
                    Obx(
                      () => NamedDropDownButton(
                        titleText: 'Rooms',
                        value: AddReservationViewStateController
                            .instance.selectedValue
                            .toString(),
                        selectOptionValue: '-1',
                        onChanged: (value) {
                          AddReservationViewStateController
                              .instance.selectedValue = value.toString();
                        },
                        itemList: List.generate(
                          10,
                          (index) => DropdownMenuItem<String>(
                            value: index.toString(),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ActionButton(
                        btnText: 'Add',
                        onTap: () {
                          AddReservationViewStateController
                              addReservationController =
                              Get.find<AddReservationViewStateController>();
                          BookingTabController bookingTabController =
                              Get.find<BookingTabController>();

                          // Collect details and create a Room object
                          Room room = Room(
                            number:
                                'Room Number : 16',
                            type: addReservationController.selectedCategory,
                            checkInDate: addReservationController.selectedDate,
                            checkOutDate: addReservationController.checkOutDate,
                            adults:
                                2, // or collect this value from an input field
                            children:
                                1, // or collect this value from an input field
                            roomCount: int.parse(
                                addReservationController.selectedValue),
                          );

                          // Add the Room to the confirmed booking list
                          bookingTabController.moveRoomToConfirmed(room);

                          // Show a dialog to navigate to the confirmed list
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Reservation Added'),
                                content: Text(
                                    'Do you want to view the confirmed list?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Close the dialog

                                      Get.off(() => BookingTabScreen());
                                    },
                                    child: Text('View'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
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
