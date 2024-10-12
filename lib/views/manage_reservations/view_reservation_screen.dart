import 'package:flutter/material.dart';
import 'package:hotel_manager/components/action_button.dart';
import 'package:hotel_manager/components/loading_dialog.dart';
import 'package:hotel_manager/components/room_tile.dart';
import 'package:hotel_manager/controllers/view/reservation/view_reservation_state_controller.dart';
import 'package:hotel_manager/enum/room_type.dart';
import 'package:hotel_manager/models/reservation.dart';
import 'package:hotel_manager/views/manage_reservations/assign_rooms_screen.dart';
import 'package:hotel_manager/views/manage_reservations/manage_reservations_screen.dart';
import 'package:intl/intl.dart';

import '../../components/named_date_input_field.dart';
import '../../components/named_input_field.dart';
import '../../constants/colour_constants.dart';
import '../../constants/text_constants.dart';

import 'package:get/get.dart';

import '../../models/room.dart';

class ViewReservationScreen extends StatelessWidget {
  const ViewReservationScreen({required this.reservation});

  final Reservation reservation;

  @override
  Widget build(BuildContext context) {
    Get.put(ViewReservationStateController());
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
                        ViewReservationStateController.instance.reinitController();
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
                      // child: ActionButton(
                      //   btnText: 'Check Availability',
                      //   outlineMode: true,
                      //   borderColour: ColourConstants.mainBlue,
                      //   borderWidth: 2.0,
                      //   onTap: () {},
                      //   width: 250,
                      // ),
                      child: FutureBuilder(
                        future: ViewReservationStateController.instance
                            .getAvailabilityStatus(
                                from: reservation.checkinDate,
                                to: reservation.checkoutDate,
                                roomType: reservation.roomType),
                        builder: (context, snapshot) {
                          String data = '';
                          if (snapshot.hasData) {
                            data = snapshot.data!;
                          } else if (snapshot.hasError) {
                            print(snapshot);
                            data = 'Error';
                          } else {
                            data = 'Fetching';
                          }
                          return RichText(
                            text: TextSpan(
                              text: 'Availability : ',
                              style: TextConstants.mainTextStyle(fontSize: 25),
                              children: [
                                TextSpan(
                                  text: data,
                                  style: TextStyle(
                                    color: ColourConstants.green1,
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Obx(
                      () => Visibility(
                        visible: ViewReservationStateController
                                .instance.availability ==
                            'Available',
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Select Rooms',
                                    style: TextConstants.mainTextStyle(
                                        fontSize: 25),
                                  ),
                                ],
                              ),
                              FutureBuilder(
                                  future: ViewReservationStateController
                                      .instance
                                      .getAvailableRoomsList(
                                          from: reservation.checkinDate,
                                          to: reservation.checkoutDate,
                                          roomType: reservation.roomType),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<Room> rooms = snapshot.data!;
                                      List<Widget> children = rooms.map((room) {
                                        return Obx(() {
                                          bool isSelected =
                                              ViewReservationStateController
                                                  .instance.selectedRoomList
                                                  .any((selectedRoom) =>
                                                      selectedRoom.id ==
                                                      room.id);
                                          bool maximumCountExceeded =
                                              ViewReservationStateController
                                                      .instance
                                                      .selectedRoomList
                                                      .length >=
                                                  reservation.roomCount;
                                          return RoomTile(
                                            roomId: room.id,
                                            roomNo: room.roomNo,
                                            color: isSelected
                                                ? ColourConstants.green1
                                                : maximumCountExceeded
                                                    ? Colors.grey.shade300
                                                    : Colors.transparent,
                                            textColor: isSelected
                                                ? ColourConstants.white
                                                : maximumCountExceeded
                                                    ? Colors.grey.shade700
                                                    : ColourConstants.richBlack,
                                            borderColor: isSelected
                                                ? ColourConstants.green1
                                                : maximumCountExceeded
                                                    ? Colors.grey.shade700
                                                    : ColourConstants.richBlack,
                                            onPressed: () {
                                              if (isSelected) {
                                                ViewReservationStateController
                                                    .instance
                                                    .removeRoomFromSelected(
                                                        roomId: room.id);
                                              } else if (maximumCountExceeded) {
                                                Get.snackbar(
                                                  'Maximum Room Count Exceeded',
                                                  'You have already selected the maximum number of rooms for this reservation.',
                                                  backgroundColor:
                                                      ColourConstants.red1,
                                                  colorText:
                                                      ColourConstants.ivory,
                                                );
                                              } else {
                                                ViewReservationStateController
                                                    .instance
                                                    .addRoomToSelected(
                                                        roomId: room.id);
                                              }
                                            },
                                          );
                                        });
                                      }).toList();
                                      return CustomScrollView(
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
                                              children: children,
                                              childAspectRatio: 2,
                                            ),
                                          ),
                                        ],
                                      );
                                    } else if (snapshot.hasError) {
                                      print(snapshot.error);
                                      return Text(
                                        'An unexpected error occurred!',
                                        style: TextConstants.subTextStyle(
                                            color: ColourConstants.red1),
                                      );
                                    } else {
                                      return Text(
                                        'Fetching rooms...',
                                        style: TextConstants.subTextStyle(
                                            color: ColourConstants.richBlack),
                                      );
                                    }
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => Visibility(
                        visible: ViewReservationStateController
                                .instance.selectedRoomList.isNotEmpty &&
                            ViewReservationStateController
                                    .instance.availability ==
                                'Available',
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: ActionButton(
                            btnText: 'Add Booking',
                            outlineMode: true,
                            borderColour: ColourConstants.green1,
                            borderWidth: 2.0,
                            onTap: () {
                              if(ViewReservationStateController.instance.selectedRoomList.length < reservation.roomCount)
                              {
                                Get.snackbar(
                                  'Room Count Mismatch',
                                  'You have not selected the required number of rooms for this reservation.',
                                  backgroundColor: ColourConstants.red1,
                                  colorText: ColourConstants.ivory,
                                );
                                return;
                              }

                              Get.dialog(
                                Dialog(
                                  child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Are you sure you want to add this booking?',
                                          style: TextConstants.subTextStyle(),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ActionButton(
                                          outlineMode: true,
                                          borderColour: ColourConstants.green1,
                                          borderWidth: 2.0,
                                          btnText: 'Yes',
                                          fontSize: 18,
                                          onTap: () {
                                            Get.back(); //exit from confirm dialog
                                            LoadingDialog(
                                                callerFunction: () async {
                                              await ViewReservationStateController
                                                  .instance
                                                  .addBooking(
                                                      reservation: reservation,);
                                            }, onErrorCallBack: (error) {
                                              print(error.toString());
                                              Get.snackbar(
                                                'Error',
                                                'An unexpected error occurred while adding the booking.',
                                                backgroundColor:
                                                    ColourConstants.red1,
                                                colorText:
                                                    ColourConstants.ivory,
                                              );
                                            });
                                            Get.back();
                                            Get.snackbar(
                                              'Reservation verified successfully',
                                              'A room booking was successfully',
                                              backgroundColor:
                                              ColourConstants.green1,
                                              colorText:
                                              ColourConstants.ivory,
                                            );
                                          },
                                          height: 40,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        ActionButton(
                                          outlineMode: true,
                                          borderColour: ColourConstants.red1,
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
                                        Get.back(); // close dialog
                                        LoadingDialog(
                                          callerFunction: () async {
                                            await ViewReservationStateController
                                                .instance
                                                .cancelReservation(
                                                    reservation: reservation);
                                          },
                                          onSuccessCallBack: () {
                                            Get.to(() => ManageReservationsScreen());
                                            Get.snackbar(
                                              'Reservation Cancelled',
                                              'The reservation was successfully cancelled.',
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
