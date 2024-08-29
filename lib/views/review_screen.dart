import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_manager/components/action_button.dart';
import 'package:hotel_manager/components/booking_tile.dart';
import 'package:hotel_manager/components/named_date_input_field.dart';
import 'package:hotel_manager/components/named_drop_down_button.dart';
import 'package:hotel_manager/components/review_tile.dart';
import 'package:hotel_manager/constants/colour_constants.dart';
import 'package:hotel_manager/controllers/view/booking_tab_controller.dart';
import 'package:hotel_manager/controllers/view/manage_reservations_screen_tab_bar_controller.dart';
import 'package:hotel_manager/enum/review_status.dart';
import 'package:hotel_manager/enum/room_type.dart';
import 'package:hotel_manager/models/booking.dart';
import 'package:hotel_manager/models/reservation.dart';
import 'package:hotel_manager/models/review.dart';
import 'package:hotel_manager/models/room.dart';
import 'package:hotel_manager/views/manage_reservations/bookings_tab_bar_view.dart';
import 'package:hotel_manager/views/manage_reservations/temp_booking_tab_bar_view.dart';
import 'package:intl/intl.dart';

import '../../constants/text_constants.dart';
import '../controllers/view/review_screen_tab_bar_controller.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    double deviceHeight = deviceSize.height;
    double deviceWidth = deviceSize.width;

    return GetBuilder<ReviewScreenTabBarController>(
      init: ReviewScreenTabBarController(),
      builder: (controller) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
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
                          'Customer Reviews',
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
                                'Pending',
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
                                'Accepted',
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
                      RefreshIndicator(
                        onRefresh: () async {
                          await Future.delayed(Duration(seconds: 1));
                        },
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                                    5,
                                    (_) => Review(
                                        id: _,
                                        name: 'Sarah Conner',
                                        feedback:
                                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus ornare dolor in massa auctor placerat. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.',
                                        createdAt: DateTime.now().subtract(
                                          Duration(
                                            days: _,
                                          ),
                                        ),
                                        status: ReviewStatus.Pending))
                                .map<ReviewTile>(
                                  (review) => ReviewTile(
                                    review: review,
                                    onAcceptTap: () {},
                                    onRejectTap: () {},
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                      RefreshIndicator(
                        onRefresh: () async {
                          await Future.delayed(Duration(seconds: 1));
                        },
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                                    15,
                                    (_) => Review(
                                        id: _,
                                        name: 'Sarah Conner',
                                        feedback: 'Nice!',
                                        createdAt: DateTime.now().subtract(
                                          Duration(
                                            days: _,
                                          ),
                                        ),
                                        status: ReviewStatus.Accepted))
                                .map<ReviewTile>(
                                  (review) => ReviewTile(
                                    review: review,
                                  ),
                                )
                                .toList(),
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
