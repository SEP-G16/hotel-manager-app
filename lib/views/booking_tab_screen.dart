import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_manager/constants/colour_constants.dart';
import '../../constants/text_constants.dart';
import 'package:hotel_manager/controllers/view/booking_tab_controller.dart';
import 'package:hotel_manager/components/named_drop_down_button.dart';
import 'package:hotel_manager/components/booking_tile.dart'; // Import the BookingTile component

class BookingTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GetBuilder<BookingTabController>(
      init: BookingTabController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: ColourConstants.white,
          body: SafeArea(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  // Back button and title
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.03,
                      vertical: screenHeight * 0.02,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.arrow_back,
                            color: ColourConstants.chineseBlack,
                            size: screenHeight * 0.04,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Booking Management',
                            style: TextConstants.mainTextStyle(
                              fontSize: screenHeight * 0.03,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Room type filter dropdown
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.03,
                    ),
                    child: NamedDropDownButton(
                      titleText: 'Filter by Room Type',
                      value: controller.selectedRoomType,
                      selectOptionValue: (value) {
                        controller.updateSelectedRoomType(value);
                      },
                      onChanged: (value) {
                        controller.updateSelectedRoomType(value);
                      },
                      itemList: [
                        DropdownMenuItem(
                          value: 'All',
                          child: Text('All'),
                        ),
                        DropdownMenuItem(
                          value: 'Standard',
                          child: Text('Standard'),
                        ),
                        DropdownMenuItem(
                          value: 'Deluxe',
                          child: Text('Deluxe'),
                        ),
                        DropdownMenuItem(
                          value: 'Family',
                          child: Text('Family'),
                        ),
                      ],
                      width: screenWidth * 0.94,
                    ),
                  ),

                  // Tabs
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.03,
                    ),
                    child: TabBar(
                      controller: controller.tabController,
                      indicatorColor: Colors.transparent,
                      dividerColor: Colors.transparent,
                      tabs: <Widget>[
                        Tab(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                            ),
                            height: screenHeight * 0.08,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: ColourConstants.mainBlue,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'Temporary',
                                style: TextConstants.subTextStyle(
                                  color: ColourConstants.chineseBlack,
                                  fontSize: screenHeight * 0.02,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                            ),
                            height: screenHeight * 0.08,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: ColourConstants.mainBlue,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'Confirmed',
                                style: TextConstants.subTextStyle(
                                  color: ColourConstants.chineseBlack,
                                  fontSize: screenHeight * 0.02,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: TabBarView(
                      controller: controller.tabController,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.08,
                            vertical: screenHeight * 0.02,
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView(
                                  children: controller.filteredTemporaryRooms
                                      .map((room) => BookingTile(
                                    itemName: room,
                                    screenWidth: screenWidth,
                                    screenHeight: screenHeight,
                                    onPressed: () {
                                      print('Arrow icon clicked for item: $room');
                                    },
                                  ))
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.08,
                            vertical: screenHeight * 0.02,
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView(
                                  children: controller.filteredConfirmedRooms
                                      .map((room) => BookingTile(
                                    itemName: room,
                                    screenWidth: screenWidth,
                                    screenHeight: screenHeight,
                                    onPressed: () {
                                      print('Arrow icon clicked for item: $room');
                                    },
                                  ))
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
