import 'package:flutter/material.dart';
import 'package:hotel_manager/components/loading_dialog.dart';
import 'package:hotel_manager/components/room_tile.dart';
import 'package:hotel_manager/controllers/data/booking_data_controller.dart';
import 'package:hotel_manager/enum/room_type.dart';
import 'package:hotel_manager/views/manage_reservations/manage_reservations_screen.dart';
import 'package:intl/intl.dart';

import '../../components/action_button.dart';
import '../../components/named_input_field.dart';
import '../../constants/colour_constants.dart';
import '../../constants/text_constants.dart';
import '../../models/booking.dart';
import 'package:get/get.dart';

class ViewBookingScreen extends StatelessWidget {
  const ViewBookingScreen({required this.booking});

  final Booking booking;

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
                        initialValue: booking.customerName,
                        onChanged: (value) {},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: NamedInputField(
                        width: double.maxFinite,
                        titleText: 'Phone No.',
                        readOnly: true,
                        initialValue: booking.phoneNo,
                        onChanged: (value) {},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: NamedInputField(
                        width: double.maxFinite,
                        titleText: 'Email',
                        readOnly: true,
                        initialValue: booking.email,
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
                              initialValue: booking.adultCount.toString(),
                              onChanged: (value) {},
                            ),
                          ),
                          Expanded(
                            child: NamedInputField(
                              titleTextStyle:
                                  TextConstants.mainTextStyle(fontSize: 18),
                              titleText: 'Children Count',
                              readOnly: true,
                              initialValue: booking.childrenCount.toString(),
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
                        initialValue: booking.roomType.getRoomTypeAsString(),
                        onChanged: (value) {},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: NamedInputField(
                        width: double.maxFinite,
                        titleText: 'Room Count',
                        readOnly: true,
                        initialValue: booking.roomCount.toString(),
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
                            .format(booking.checkinDate),
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
                            .format(booking.checkoutDate),
                        onChanged: (value) {},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: NamedInputField(
                        width: double.maxFinite,
                        titleText: 'Total Amount',
                        readOnly: true,
                        initialValue: booking.totalAmount.toStringAsFixed(2),
                        onChanged: (value) {},
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Assigned Rooms',
                                style:
                                    TextConstants.mainTextStyle(fontSize: 25),
                              ),
                            ],
                          ),
                          CustomScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            primary: false,
                            slivers: [
                              SliverPadding(
                                padding: EdgeInsets.all(5),
                                sliver: SliverGrid.count(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                  children: booking.rooms
                                      .map(
                                        (room) => RoomTile(
                                          roomId: room.id,
                                          roomNo: room.roomNo,
                                        ),
                                      )
                                      .toList(),
                                  childAspectRatio: 2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: ActionButton(
                        btnText: 'Cancel Booking',
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
                                        Get.back(); // close dialog
                                        LoadingDialog(
                                          callerFunction: () async {
                                            await BookingDataController.instance.cancelBooking(bookingId: booking.id);
                                          },
                                          onSuccessCallBack: () {
                                            Get.to(() => ManageReservationsScreen());
                                            Get.snackbar(
                                              'Reservation Cancelled',
                                              'The booking was successfully cancelled.',
                                              backgroundColor: ColourConstants.green1,
                                              colorText: ColourConstants.ivory,
                                            );
                                          },
                                          onErrorCallBack: (error) {
                                            print(error.toString());
                                            Get.snackbar(
                                              'Error',
                                              'An unexpected error occurred while cancelling the reservation.',
                                              backgroundColor: ColourConstants.red1,
                                              colorText: ColourConstants.ivory,
                                            );
                                          },
                                        );
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
                    SizedBox(
                      height: 20,
                    ),
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
