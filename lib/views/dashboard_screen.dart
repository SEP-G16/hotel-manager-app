import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hotel_manager/components/action_button.dart';
import 'package:hotel_manager/components/custom_drawer.dart';
import 'package:hotel_manager/constants/colour_constants.dart';
import 'package:hotel_manager/constants/svg_constants.dart';
import 'package:hotel_manager/constants/text_constants.dart';
import 'package:hotel_manager/controllers/view/dashboard_state_controller.dart';
import 'package:hotel_manager/controllers/view/drawer_state_controller.dart';
import 'package:hotel_manager/views/manage_staff/manage_staff_screen.dart';
import 'package:hotel_manager/views/manage_reservations/manage_reservations_screen.dart';
import 'package:hotel_manager/views/message_screen.dart';
import 'package:hotel_manager/views/profile_screen.dart';
import 'package:hotel_manager/views/review_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      DrawerStateController.instance.selectedIndex =
          DrawerStateController.DASHBAORD_INDEX;
    });

    return Scaffold(
      drawer: CustomDrawer(),
      backgroundColor: ColourConstants.ivory,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Builder(builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: Icon(
                          Icons.menu_rounded,
                          size: 30,
                        ),
                      );
                    }),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Dashboard',
                      style: TextConstants.mainTextStyle(fontSize: 32),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Stats',
                              style: TextConstants.mainTextStyle(fontSize: 28),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      DrawerStateController
                                              .instance.selectedIndex =
                                          DrawerStateController.BOOKINGS_INDEX;
                                      Get.to(() => ManageReservationsScreen());
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: ColourConstants.mainBlue,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Reservations',
                                            style: TextConstants.subTextStyle(
                                                color: ColourConstants.white),
                                          ),
                                          Obx(
                                            () => Text(
                                              DashboardStateController
                                                  .instance.reservationCount
                                                  .toString(),
                                              style:
                                                  TextConstants.mainTextStyle(
                                                      color: ColourConstants
                                                          .white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      DrawerStateController
                                              .instance.selectedIndex =
                                          DrawerStateController.BOOKINGS_INDEX;
                                      Get.to(() => ManageReservationsScreen());
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: ColourConstants.mainBlue,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Bookings',
                                            style: TextConstants.subTextStyle(
                                                color: ColourConstants.white),
                                          ),
                                          Obx(
                                            () => Text(
                                              DashboardStateController
                                                  .instance.bookingCount
                                                  .toString(),
                                              style:
                                                  TextConstants.mainTextStyle(
                                                      color: ColourConstants
                                                          .white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      DrawerStateController
                                              .instance.selectedIndex =
                                          DrawerStateController.REVIEWS_INDEX;
                                      Get.to(() => ReviewScreen());
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: ColourConstants.mainBlue,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Reviews',
                                            style: TextConstants.subTextStyle(
                                                color: ColourConstants.white),
                                          ),
                                          Obx(
                                            () => Text(
                                              DashboardStateController
                                                  .instance.reviewCount
                                                  .toString(),
                                              style:
                                                  TextConstants.mainTextStyle(
                                                      color: ColourConstants
                                                          .white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      DrawerStateController
                                              .instance.selectedIndex =
                                          DrawerStateController.MESSAGES_INDEX;
                                      Get.to(() => MessageScreen());
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: ColourConstants.mainBlue,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Messages',
                                            style: TextConstants.subTextStyle(
                                                color: ColourConstants.white),
                                          ),
                                          Obx(
                                            () => Text(
                                              DashboardStateController
                                                  .instance.messageCount
                                                  .toString(),
                                              style:
                                                  TextConstants.mainTextStyle(
                                                      color: ColourConstants
                                                          .white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              'Staff',
                              style: TextConstants.mainTextStyle(fontSize: 28),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            DrawerStateController.instance.selectedIndex =
                                DrawerStateController.STAFF_INDEX;
                            Get.to(() => ManageStaffScreen());
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: ColourConstants.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: ColourConstants.mainBlue, width: 2),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.string(
                                  SvgConstants.employeeGroupImage,
                                  height: 100,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    'Manage your Employees',
                                    style: TextConstants.subTextStyle(
                                        fontSize: 22),
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SvgPicture.string(
                          SvgConstants.dashboardScreenImage,
                          width: MediaQuery.of(context).size.width * 0.7,
                        ),
                        Text(
                          'Time to Start Managing your Hotel!',
                          style: TextConstants.subTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
