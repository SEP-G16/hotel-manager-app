import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_manager/components/custom_drawer.dart';
import 'package:hotel_manager/constants/colour_constants.dart';
import 'package:hotel_manager/controllers/view/drawer_state_controller.dart';
import 'package:hotel_manager/controllers/view/reservation/manage_reservartions_screen_state_controller.dart';
import 'package:hotel_manager/controllers/view/reservation/manage_reservations_screen_tab_bar_controller.dart';
import 'package:hotel_manager/views/manage_reservations/bookings_tab_bar_view.dart';
import 'package:hotel_manager/views/manage_reservations/temp_booking_tab_bar_view.dart';


import '../../constants/text_constants.dart';
import '../../controllers/data/booking_data_controller.dart';

class ManageReservationsScreen extends StatelessWidget {
  const ManageReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_){
      DrawerStateController.instance.selectedIndex = DrawerStateController.BOOKINGS_INDEX;
    });


    Size deviceSize = MediaQuery.of(context).size;
    double deviceHeight = deviceSize.height;
    double deviceWidth = deviceSize.width;

    Get.put(BookingTabViewScreenStateController());
    Get.put(TempBookingTabViewScreenStateController());

    return GetBuilder<ManageReservationsScreenTabBarController>(
      init: ManageReservationsScreenTabBarController(),
      builder: (controller) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          drawer: CustomDrawer(),
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
                        child: Builder(builder: (context) {
                          return GestureDetector(
                            onTap: () {
                              Scaffold.of(context).openDrawer();
                            },
                            child: Icon(
                              Icons.menu_rounded,
                              color: ColourConstants.richBlack,
                              size: 30,
                            ),
                          );
                        }),
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
                                  fontSize: 15,
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
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: TabBarView(
                    controller: controller.tabController,
                    children: [
                      TempBookingTabBarView(
                        reservations: BookingDataController
                            .instance.listenableReservationList,
                      ),
                      BookingsTabBarView(
                        bookings: BookingDataController
                            .instance.listenableBookingList,
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
