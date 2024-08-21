import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hotel_manager/components/named_date_input_field.dart';
import 'package:hotel_manager/components/named_drop_down_button.dart';
import 'package:hotel_manager/constants/colour_constants.dart';
import 'package:hotel_manager/controllers/view/reservation_details_view_state_controller.dart';
import 'package:get/get.dart';

import '../components/named_input_field.dart';
import '../constants/text_constants.dart';

class ReservationDetailsScreen extends StatelessWidget {
  ReservationDetailsScreen({super.key}) {
    Get.put(ReservationDetailsViewStateController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColourConstants.ivory,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
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
                      'Reservation Details',
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
                    // Replace the Avatar with the Uploaded Image
                    Text(
                      'Room 145\nDeluxe',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: ColourConstants.richBlack,
                      ),
                    ),
                    SizedBox(height: 20),

                    NamedInputField(titleText: 'Customer Name', onChanged: (value) {}),

                    // Check-In Date
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
                            ReservationDetailsViewStateController.instance.selectedDate = selectedDate;
                          }
                        },
                        selectedDate: ReservationDetailsViewStateController.instance.selectedDate,
                      ),
                    ),

                    // Check-Out Date
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
                            ReservationDetailsViewStateController.instance.selectedDate = selectedDate;
                          }
                        },
                        selectedDate: ReservationDetailsViewStateController.instance.selectedDate,
                      ),
                    ),

                    // Room Selection
                    Obx(
                          () => NamedDropDownButton(
                        titleText: 'Rooms',
                        value: ReservationDetailsViewStateController.instance.selectedValue,
                        selectOptionValue: -1,
                        onChanged: (value) {
                          ReservationDetailsViewStateController.instance.selectedValue = value;
                        },
                        itemList: List.generate(
                          10,
                              (index) => DropdownMenuItem(
                            value: index,
                            child: Text(
                              '$index',
                              style: TextStyle(fontSize: 16, color: ColourConstants.mainBlue),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Room Category
                    Obx(
                          () => NamedDropDownButton(
                        titleText: 'Room Category',
                        value: ReservationDetailsViewStateController.instance.selectedCategory,
                        selectOptionValue: 'Select',
                        onChanged: (value) {
                          ReservationDetailsViewStateController.instance.selectedCategory = value;
                        },
                        itemList: ['Standard', 'Deluxe', 'Family']
                            .map<DropdownMenuItem<String>>(
                              (category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category,
                              style: TextStyle(fontSize: 16, color: ColourConstants.mainBlue),
                            ),
                          ),
                        ).toList(),
                      ),
                    ),

                    // Adults and Children Count
                Padding(

                  padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
                    child: Row(

                      children: [
                        // Adults
                        Expanded(
                          child: Obx(
                                () => NamedDropDownButton(
                              titleText: 'Adults',
                              value: ReservationDetailsViewStateController.instance.selectedValue,
                              selectOptionValue: -1,
                              onChanged: (value) {
                                ReservationDetailsViewStateController.instance.selectedValue = value;
                              },
                              itemList: List.generate(
                                10,
                                    (index) => DropdownMenuItem(
                                  value: index,
                                  child: Text(
                                    '$index',
                                    style: TextStyle(fontSize: 16, color: ColourConstants.mainBlue),
                                  ),
                                ),
                              ),
                              width: 150, // Adjust the width for the Adults dropdown
                               // Adjust the height for the Adults dropdown (if needed)
                            ),
                          ),
                        ),
                        SizedBox(width: 10), // Space between dropdowns
                        // Children
                        Expanded(
                          child: Obx(
                                () => NamedDropDownButton(
                              titleText: 'Children',
                              value: ReservationDetailsViewStateController.instance.selectedValue,
                              selectOptionValue: -1,
                              onChanged: (value) {
                                ReservationDetailsViewStateController.instance.selectedValue = value;
                              },
                              itemList: List.generate(
                                10,
                                    (index) => DropdownMenuItem(
                                  value: index,
                                  child: Text(
                                    '$index',
                                    style: TextStyle(fontSize: 16, color: ColourConstants.mainBlue),
                                  ),
                                ),
                              ),
                              width: 150, // Adjust the width for the Children dropdown
                               // Adjust the height for the Children dropdown (if needed)
                            ),
                          ),
                        ),
                      ],
                    ),
                ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            _showPopup(context, 'Accept');
                          },
                          child: Text(
                            'Accept',
                            style: TextStyle(
                                fontSize: 25, color: ColourConstants.richBlack),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColourConstants.green,
                            minimumSize: Size(100, 60),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _showPopup(context, 'Reject');
                          },
                          child: Text('Reject',
                              style: TextStyle(

                                  fontSize: 25,
                                  color: ColourConstants.richBlack)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColourConstants.red,
                            minimumSize: Size(100, 60),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 35.0),
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

void _showPopup(BuildContext context, String action) {
  if (action == 'Accept') {
    // Directly show a success message for Accept
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: 400.0),
        content: Text('Reservation accepted successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  } else if (action == 'Reject') {
    // Show confirmation dialog for Reject
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reject Reservation'),
          content: Text('Are you sure you want to reject this reservation?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Show success message after confirmation
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.only(bottom: 400.0),
                    content: Text('Reservation rejected successfully!'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
