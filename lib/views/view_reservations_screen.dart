import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_manager/components/action_button.dart';
import 'package:hotel_manager/components/booking_tile.dart';
import 'package:hotel_manager/constants/colour_constants.dart';
import 'package:hotel_manager/controllers/view/booking_tab_controller.dart';
import 'package:hotel_manager/controllers/view/view_reservations_screen_tab_bar_controller.dart';
import 'package:intl/intl.dart';

import '../constants/text_constants.dart';

class ViewReservationsScreen extends StatelessWidget {
  const ViewReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewReservationsScreenTabBarController>(
      init: ViewReservationsScreenTabBarController(),
      builder: (controller) => Scaffold(
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
                    overlayColor:
                        WidgetStateColor.resolveWith((_) => Colors.transparent),
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
                    SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                          10,
                          (index) => Container(
                            padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              color: ColourConstants.orchidAccent,
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
                            child: Row(
                              children: [
                                Expanded(
                                  flex : 2,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Michael Clark',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextConstants.subTextStyle(fontSize: 18),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Phone No. : ${'0771234567'}',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextConstants.subTextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Row(
                                      //   children: [
                                      //     Expanded(
                                      //       child: Text(
                                      //         'Email : ${'michael.clark2222222222222222222@example.com'}',
                                      //         style: TextConstants.subTextStyle(fontSize: 16),
                                      //         overflow: TextOverflow.ellipsis,
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Room Type : ${'Deluxe'}',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextConstants.subTextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Room Count : ${'4'}',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextConstants.subTextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      //Moving to separate view reservation page
                                      // Row(
                                      //   children: [
                                      //     Text(
                                      //       'Check In Date : ${DateFormat('yyyy/MM/dd').format(DateTime.now())}',
                                      //       style: TextConstants.subTextStyle(fontSize: 16),
                                      //     ),
                                      //   ],
                                      // ),
                                      // Row(
                                      //   children: [
                                      //     Text(
                                      //       'Checkout Date : ${DateFormat('yyyy/MM/dd').format(DateTime.now())}',
                                      //       style: TextConstants.subTextStyle(fontSize: 16),
                                      //     ),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                                Expanded(child: Column(
                                  children: [
                                    ActionButton(btnText: 'View', onTap: (){}, height: 50, width: 100,),
                                  ],
                                ),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                          10,
                          (index) => BookingTile(room: Room(number: '101', type: 'Standard', checkInDate: DateTime.now(), checkOutDate: DateTime.now(), adults: 2, children: 1, roomCount: 3), onPressed: (){}),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
