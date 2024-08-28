import 'package:flutter/material.dart';
import 'package:hotel_manager/components/named_date_input_field.dart';
import 'package:hotel_manager/components/named_drop_down_button.dart';
import 'package:hotel_manager/constants/colour_constants.dart';
import 'package:hotel_manager/controllers/view/reservation_details_view_state_controller.dart';
import 'package:get/get.dart';

import '../components/named_input_field.dart';
import '../constants/text_constants.dart';
import '../controllers/view/booking_tab_controller.dart';

class ReservationDetailsScreen extends StatelessWidget {
  final Room room;
  final BookingTabController bookingTabController = Get.find<BookingTabController>();

  ReservationDetailsScreen({Key? key, required this.room}) : super(key: key) {
    Get.put(ReservationDetailsViewStateController());
    // Fetch or set up data related to roomId
    ReservationDetailsViewStateController.instance.selectedDate = room.checkInDate;
    ReservationDetailsViewStateController.instance.selectedCategory = room.type;
    ReservationDetailsViewStateController.instance.selectedAdults = room.adults;
    ReservationDetailsViewStateController.instance.selectedChildren = room.children;
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
                      onTap: () {
                        Navigator.pop(context); // Navigate back to the booking screen
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
                    Text(
                      '${room.number}\n${room.type}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: ColourConstants.richBlack,
                      ),
                    ),
                    SizedBox(height: 20),

                    NamedInputField(titleText: 'Customer Name', onChanged: (value) {}),

                    Obx(
                          () => NamedDateInputField(
                        titleText: 'Check In Date',
                        onPressed: () async {
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime(DateTime.now().year - 100),
                            lastDate: DateTime.now(),
                            initialDate: ReservationDetailsViewStateController.instance.selectedDate ?? room.checkInDate,
                          );
                          if (selectedDate != null) {
                            ReservationDetailsViewStateController.instance.selectedDate = selectedDate;
                          }
                        },
                        selectedDate: ReservationDetailsViewStateController.instance.selectedDate,
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
                            initialDate: ReservationDetailsViewStateController.instance.selectedDate ?? room.checkOutDate,
                          );
                          if (selectedDate != null) {
                            ReservationDetailsViewStateController.instance.selectedDate = selectedDate;
                          }
                        },
                        selectedDate: ReservationDetailsViewStateController.instance.selectedDate,
                      ),
                    ),

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

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Obx(
                                  () => NamedDropDownButton(
                                titleText: 'Adults',
                                value: ReservationDetailsViewStateController.instance.selectedAdults,
                                selectOptionValue: -1,
                                onChanged: (value) {
                                  ReservationDetailsViewStateController.instance.selectedAdults = value;
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
                                width: 150,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Obx(
                                  () => NamedDropDownButton(
                                titleText: 'Children',
                                value: ReservationDetailsViewStateController.instance.selectedChildren,
                                selectOptionValue: -1,
                                onChanged: (value) {
                                  ReservationDetailsViewStateController.instance.selectedChildren = value;
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
                                width: 150,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 35.0),
                    ElevatedButton(
                      onPressed: () {
                        _showPopup(context, 'Reject');
                        bookingTabController.cancelReservation(room);
                        //send and email to customer
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
                    SizedBox(height: 35.0),
                  ],
                ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

void _showPopup(BuildContext context, String action) {
  if (action == 'Accept') {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: 400.0),
        content: Text('Reservation accepted successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  } else if (action == 'Reject') {
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


