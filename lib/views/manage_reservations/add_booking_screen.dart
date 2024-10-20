import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_manager/components/action_button.dart';
import 'package:hotel_manager/components/message_dialog_box.dart';
import 'package:hotel_manager/components/named_date_input_field.dart';
import 'package:hotel_manager/components/named_drop_down_button.dart';
import 'package:hotel_manager/components/named_input_field.dart';
import 'package:hotel_manager/constants/colour_constants.dart';
import 'package:hotel_manager/constants/text_constants.dart';
import 'package:hotel_manager/controllers/view/reservation/add_booking_view_state_controller.dart';
import 'package:hotel_manager/controllers/view/reservation/manage_reservartions_screen_state_controller.dart';
import 'package:hotel_manager/enum/room_type.dart';
import 'package:hotel_manager/models/form_valid_response.dart';

import '../../components/loading_dialog.dart';
import '../../components/room_tile.dart';
import '../../models/room.dart';

class AddBookingScreen extends StatelessWidget {
  AddBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetBuilder(
          init: AddBookingViewStateController(),
          builder: (controller) {
            return Scaffold(
              backgroundColor: ColourConstants.ivory,
              body: SafeArea(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
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
                                  controller.name = value!;
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: NamedInputField(
                                width: double.maxFinite,
                                titleText: 'Phone No.',
                                onChanged: (value) {
                                  controller.phoneNo = value!;
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: NamedInputField(
                                width: double.maxFinite,
                                titleText: 'Email',
                                onChanged: (value) {
                                  controller.email = value!;
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: NamedInputField(
                                      titleTextStyle:
                                          TextConstants.mainTextStyle(
                                              fontSize: 18),
                                      titleText: 'Adult Count',
                                      initialValue: 0.toString(),
                                      onChanged: (value) {
                                        controller.selectedAdultCount = value!;
                                      },
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  Expanded(
                                    child: NamedInputField(
                                      titleTextStyle:
                                          TextConstants.mainTextStyle(
                                              fontSize: 18),
                                      titleText: 'Children Count',
                                      initialValue: 0.toString(),
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        controller.selectedChildrenCount =
                                            value!;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Obx(
                                () => NamedDropDownButton<String>(
                                  width: double.maxFinite,
                                  titleText: 'Room Category',
                                  value: controller.selectedCategory,
                                  includeSelectOption: false,
                                  selectOptionValue: 'Select',
                                  onChanged: (value) {
                                    controller.selectedCategory = value!;
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
                                initialValue: 1.toString(),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  if(int.parse(value!) <= 0)
                                    {
                                      Get.snackbar('Invalid Room Count', 'Room Count must be equal or greater than 1');
                                    }
                                  else
                                    {
                                      controller.selectedRoomCount = value;
                                    }
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Obx(
                                () => NamedDateInputField(
                                  width: double.maxFinite,
                                  titleText: 'Check In Date',
                                  onPressed: () async {
                                    DateTime? selectedDate =
                                        await showDatePicker(
                                      context: context,
                                      firstDate:
                                          DateTime.now(),
                                      lastDate: DateTime.now().add(Duration(days: 365)),
                                    );
                                    if (selectedDate != null) {
                                      controller.checkInDate = selectedDate;
                                    }
                                  },
                                  selectedDate: controller.checkInDate,
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
                                    DateTime? selectedDate =
                                        await showDatePicker(
                                      context: context,
                                      firstDate:
                                          DateTime.now().add(Duration(days: 1)),
                                      lastDate: DateTime.now().add(Duration(days: 366)),
                                    );
                                    if (selectedDate != null) {
                                      if(controller.checkInDate.isAfter(selectedDate))
                                        {
                                          Get.snackbar('Invalid Check Out Date', 'Check Out Date must be after Check In Date');
                                        }
                                      else
                                        {
                                          controller.checkOutDate = selectedDate;
                                        }
                                    }
                                  },
                                  selectedDate: controller.checkOutDate,
                                ),
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
                              child: Obx(
                                () {
                                  String data = AddBookingViewStateController.instance.availability;
                                  return RichText(
                                      text: TextSpan(
                                        text: 'Availability : ',
                                        style: TextConstants.mainTextStyle(
                                            fontSize: 25),
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
                                    );}
                              ),
                            ),
                            Obx(
                              () => Visibility(
                                visible: AddBookingViewStateController
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
                                          future: AddBookingViewStateController
                                              .instance
                                              .getAvailableRoomsList(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              List<Room> rooms = snapshot.data!;
                                              List<Widget> children =
                                                  rooms.map((room) {
                                                return Obx(() {
                                                  bool isSelected =
                                                      AddBookingViewStateController
                                                          .instance
                                                          .selectedRoomList
                                                          .any((selectedRoom) =>
                                                              selectedRoom.id ==
                                                              room.id);
                                                  bool maximumCountExceeded =
                                                      AddBookingViewStateController
                                                              .instance
                                                              .selectedRoomList
                                                              .length >=
                                                          int.parse(controller.selectedRoomCount);
                                                  return RoomTile(
                                                    roomId: room.id,
                                                    roomNo: room.roomNo,
                                                    color: isSelected
                                                        ? ColourConstants.green1
                                                        : maximumCountExceeded
                                                            ? Colors
                                                                .grey.shade300
                                                            : Colors
                                                                .transparent,
                                                    textColor: isSelected
                                                        ? ColourConstants.white
                                                        : maximumCountExceeded
                                                            ? Colors
                                                                .grey.shade700
                                                            : ColourConstants
                                                                .richBlack,
                                                    borderColor: isSelected
                                                        ? ColourConstants.green1
                                                        : maximumCountExceeded
                                                            ? Colors
                                                                .grey.shade700
                                                            : ColourConstants
                                                                .richBlack,
                                                    onPressed: () {
                                                      if (isSelected) {
                                                        AddBookingViewStateController
                                                            .instance
                                                            .removeRoomFromSelected(
                                                                roomId:
                                                                    room.id);
                                                      } else if (maximumCountExceeded) {
                                                        Get.snackbar(
                                                          'Maximum Room Count Exceeded',
                                                          'You have already selected the maximum number of rooms for this reservation.',
                                                          backgroundColor:
                                                              ColourConstants
                                                                  .red1,
                                                          colorText:
                                                              ColourConstants
                                                                  .ivory,
                                                        );
                                                      } else {
                                                        AddBookingViewStateController
                                                            .instance
                                                            .addRoomToSelected(
                                                                roomId:
                                                                    room.id);
                                                      }
                                                    },
                                                  );
                                                });
                                              }).toList();
                                              return CustomScrollView(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
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
                                                style:
                                                    TextConstants.subTextStyle(
                                                        color: ColourConstants
                                                            .red1),
                                              );
                                            } else {
                                              return Text(
                                                'Fetching rooms...',
                                                style:
                                                    TextConstants.subTextStyle(
                                                        color: ColourConstants
                                                            .richBlack),
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
                                visible: AddBookingViewStateController
                                        .instance.selectedRoomList.isNotEmpty &&
                                    AddBookingViewStateController
                                            .instance.availability ==
                                        'Available',
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: ActionButton(
                                    btnText: 'Add Booking',
                                    outlineMode: true,
                                    borderColour: ColourConstants.green1,
                                    borderWidth: 2.0,
                                    onTap: () {
                                      if (AddBookingViewStateController
                                              .instance
                                              .selectedRoomList
                                              .length <
                                          int.parse(controller.selectedRoomCount)) {
                                        Get.snackbar(
                                          'Room Count Mismatch',
                                          'You have not selected the required number of rooms for this reservation.',
                                          backgroundColor: ColourConstants.red1,
                                          colorText: ColourConstants.ivory,
                                        );
                                        return;
                                      }

                                      FormValidResponse response = controller.validateForm();
                                      if(!response.formValid)
                                      {
                                        MessageDialogBox(message: response.message!);
                                      }
                                      else
                                      {
                                        Get.dialog(
                                          Dialog(
                                            child: Container(
                                              padding: EdgeInsets.all(10.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    'Are you sure you want to add this booking?',
                                                    style: TextConstants
                                                        .subTextStyle(),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  ActionButton(
                                                    outlineMode: true,
                                                    borderColour:
                                                    ColourConstants.green1,
                                                    borderWidth: 2.0,
                                                    btnText: 'Yes',
                                                    fontSize: 18,
                                                    onTap: () {
                                                      Get.back(); //exit from confirm dialog
                                                      LoadingDialog(
                                                          callerFunction:
                                                              () async {
                                                            await AddBookingViewStateController
                                                                .instance
                                                                .addBooking();

                                                            await BookingTabViewScreenStateController.instance.reInitController();
                                                          }, onErrorCallBack:
                                                          (error) {
                                                        print(error.toString());
                                                        Get.snackbar(
                                                          'Error',
                                                          'An unexpected error occurred while adding the booking.',
                                                          backgroundColor:
                                                          ColourConstants
                                                              .red1,
                                                          colorText:
                                                          ColourConstants
                                                              .ivory,
                                                        );
                                                      });
                                                      Get.back();
                                                      controller.reInitController();
                                                      Get.back();
                                                      Get.snackbar(
                                                        'Booking created successfully',
                                                        'A room booking was successfully',
                                                        backgroundColor:
                                                        ColourConstants
                                                            .green1,
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
                                                    borderColour:
                                                    ColourConstants.red1,
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
                                      }
                                    },
                                    width: 250,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
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
                            SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
