import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_manager/components/action_button.dart';
import 'package:hotel_manager/components/booking_tile.dart';
import 'package:hotel_manager/components/named_date_input_field.dart';
import 'package:hotel_manager/components/named_drop_down_button.dart';
import 'package:hotel_manager/constants/colour_constants.dart';
import 'package:hotel_manager/controllers/view/booking_tab_controller.dart';
import 'package:hotel_manager/controllers/view/manage_reservations_screen_tab_bar_controller.dart';
import 'package:hotel_manager/enum/room_type.dart';
import 'package:hotel_manager/models/booking.dart';
import 'package:hotel_manager/models/reservation.dart';
import 'package:hotel_manager/models/room.dart';
import 'package:hotel_manager/views/manage_reservations/bookings_tab_bar_view.dart';
import 'package:hotel_manager/views/manage_reservations/temp_booking_tab_bar_view.dart';
import 'package:intl/intl.dart';

import '../../constants/text_constants.dart';

class ManageReservationsScreen extends StatelessWidget {
  const ManageReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    double deviceHeight = deviceSize.height;
    double deviceWidth = deviceSize.width;

    return GetBuilder<ManageReservationsScreenTabBarController>(
      init: ManageReservationsScreenTabBarController(),
      builder: (controller) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          drawer: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              width: deviceWidth * 0.8,
              color: ColourConstants.white,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Filters',
                            style: TextConstants.mainTextStyle(),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.close_rounded,
                              color: ColourConstants.mainBlue,
                              size: 35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  NamedDateInputField(
                    titleText: 'Filter by Check In Date',
                    onPressed: () {},
                    titleTextStyle: TextConstants.mainTextStyle(fontSize: 20),
                  ),
                  NamedDateInputField(
                    titleText: 'Filter by Checkout Date',
                    onPressed: () {},
                    titleTextStyle: TextConstants.mainTextStyle(fontSize: 20),
                  ),
                  NamedDropDownButton(
                    titleText: 'Filter by Room Type',
                    titleTextStyle: TextConstants.mainTextStyle(fontSize: 20),
                    value: 'All',
                    selectOptionValue: 'Select',
                    onChanged: (value) {},
                    itemList: [
                          DropdownMenuItem(
                            value: 'All',
                            child: Text(
                              'All',
                              style: TextConstants.subTextStyle(),
                            ),
                          )
                        ] +
                        RoomType.values
                            .map<DropdownMenuItem<String>>(
                                (type) => DropdownMenuItem(
                                      value: type.getRoomTypeAsString(),
                                      child: Text(
                                        type.getRoomTypeAsString(),
                                        style: TextConstants.subTextStyle(),
                                      ),
                                    ))
                            .toList(),
                  )
                ],
              ),
            ),
          ),
          backgroundColor: ColourConstants.ivory,
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                          'Hotel Bookings',
                          style: TextConstants.mainTextStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Obx(
                    () => TabBar(
                      indicatorColor: Colors.transparent,
                      dividerColor: Colors.transparent,
                      controller: controller.tabController,
                      overlayColor: WidgetStateColor.resolveWith(
                          (_) => Colors.transparent),
                      tabs: <Widget>[
                        Tab(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            height: 60,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: controller.selectedIndex == 0
                                  ? ColourConstants.mainBlue
                                  : Colors.white,
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
                            ),
                            child: Center(
                              child: Text(
                                'Reservations',
                                style: TextConstants.subTextStyle(
                                  color: controller.selectedIndex == 0
                                      ? ColourConstants.ivory
                                      : ColourConstants.richBlack,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            height: 60,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: controller.selectedIndex == 1
                                  ? ColourConstants.mainBlue
                                  : Colors.white,
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
                            ),
                            child: Center(
                              child: Text(
                                'Bookings',
                                style: TextConstants.subTextStyle(
                                  color: controller.selectedIndex == 1
                                      ? ColourConstants.ivory
                                      : ColourConstants.richBlack,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: controller.tabController,
                    children: [
                      TempBookingTabBarView(
                        reservations: List.generate(
                          5,
                          (index) => Reservation(
                            id: 1,
                            createdAt:
                                DateTime.now().add(Duration(hours: index)),
                            customerName: 'Michael Clark',
                            phoneNo: '0771234567',
                            roomType: RoomType.Family,
                            roomCount: 3,
                            checkinDate:
                                DateTime.now().add(Duration(days: index)),
                            checkoutDate:
                                DateTime.now().add(Duration(days: index * 2)),
                            adultCount: 5,
                            childrenCount: 3,
                            email: 'michaelclark@example.com',
                            totalAmount: 12000.0,
                          ),
                        ),
                      ),
                      BookingsTabBarView(
                        bookings: List.generate(
                          5,
                          (index) => Booking(
                            id: index,
                            customerName: 'Michael Clark',
                            phoneNo: '0771234567',
                            roomType: RoomType.Family,
                            roomCount: 3,
                            checkinDate:
                                DateTime.now().add(Duration(days: index)),
                            checkoutDate:
                                DateTime.now().add(Duration(days: index * 2)),
                            adultCount: 5,
                            childrenCount: 3,
                            email: 'michaelclark@example.com',
                            totalAmount: 12000.0,
                            rooms: List.generate(
                              3,
                              (rIndex) => Room(
                                  id: index,
                                  roomNo: '10${rIndex}',
                                  roomType: RoomType.Family),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
