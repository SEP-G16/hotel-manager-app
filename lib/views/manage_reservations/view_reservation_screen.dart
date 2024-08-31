import 'package:flutter/material.dart';
import 'package:hotel_manager/components/action_button.dart';
import 'package:hotel_manager/enum/room_type.dart';
import 'package:hotel_manager/models/reservation.dart';
import 'package:hotel_manager/views/manage_reservations/assign_rooms_screen.dart';
import 'package:intl/intl.dart';

import '../../components/named_date_input_field.dart';
import '../../components/named_input_field.dart';
import '../../constants/colour_constants.dart';
import '../../constants/text_constants.dart';

import 'package:get/get.dart';

class ViewReservationScreen extends StatelessWidget {
  const ViewReservationScreen({required this.reservation});

  final Reservation reservation;

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
                      'View Reservation',
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
                        readOnly: true,
                        initialValue: reservation.customerName,
                        onChanged: (value) {},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: NamedInputField(
                        width: double.maxFinite,
                        titleText: 'Phone No.',
                        readOnly: true,
                        initialValue: reservation.phoneNo,
                        onChanged: (value) {},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: NamedInputField(
                        width: double.maxFinite,
                        titleText: 'Email',
                        readOnly: true,
                        initialValue: reservation.email,
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
                              readOnly: true,
                              initialValue: reservation.adultCount.toString(),
                              onChanged: (value) {},
                            ),
                          ),
                          Expanded(
                            child: NamedInputField(
                              titleTextStyle:
                                  TextConstants.mainTextStyle(fontSize: 18),
                              titleText: 'Children Count',
                              readOnly: true,
                              initialValue:
                                  reservation.childrenCount.toString(),
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: NamedInputField(
                        width: double.maxFinite,
                        titleText: 'Room Type',
                        readOnly: true,
                        initialValue:
                            reservation.roomType.getRoomTypeAsString(),
                        onChanged: (value) {},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: NamedInputField(
                        width: double.maxFinite,
                        titleText: 'Room Count',
                        readOnly: true,
                        initialValue: reservation.roomCount.toString(),
                        onChanged: (value) {},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: NamedInputField(
                        width: double.maxFinite,
                        titleText: 'Check In Date',
                        readOnly: true,
                        initialValue: DateFormat('yyyy-MM-dd')
                            .format(reservation.checkinDate),
                        onChanged: (value) {},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: NamedInputField(
                        width: double.maxFinite,
                        titleText: 'Checkout Date',
                        readOnly: true,
                        initialValue: DateFormat('yyyy-MM-dd')
                            .format(reservation.checkoutDate),
                        onChanged: (value) {},
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
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ActionButton(
                        btnText: 'Assign Rooms',
                        outlineMode: true,
                        borderColour: ColourConstants.green1,
                        borderWidth: 2.0,
                        onTap: () => Get.to(() => AssignRoomsScreen()),
                        width: 250,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ActionButton(
                        btnText: 'Cancel Reservation',
                        outlineMode: true,
                        borderColour: ColourConstants.red1,
                        borderWidth: 2.0,
                        onTap: () {
                          Get.dialog(
                            Dialog(
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Are you sure you want to cancel this reservation?',
                                      style: TextConstants.subTextStyle(),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    ActionButton(
                                      outlineMode: true,
                                      borderColour: ColourConstants.red1,
                                      borderWidth: 2.0,
                                      btnText: 'Yes',
                                      fontSize: 18,
                                      onTap: () {
                                        //TODO: reservation remove functionality
                                      },
                                      height: 40,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ActionButton(
                                      outlineMode: true,
                                      borderColour:
                                      ColourConstants.chineseBlack,
                                      borderWidth: 2.0,
                                      btnText: 'No',
                                      fontSize: 18,
                                      height: 40,
                                      onTap: () {
                                        Get.back();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        width: 250,

                      ),
                    ),
                    SizedBox(height: 20,),
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
