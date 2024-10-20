import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hotel_manager/components/action_button.dart';
import 'package:hotel_manager/constants/colour_constants.dart';
import 'package:hotel_manager/constants/svg_constants.dart';
import 'package:hotel_manager/constants/text_constants.dart';
import 'package:hotel_manager/controllers/data/auth_controller.dart';
import 'package:hotel_manager/controllers/view/drawer_state_controller.dart';
import 'package:hotel_manager/views/dashboard_screen.dart';
import 'package:hotel_manager/views/manage_reservations/manage_reservations_screen.dart';
import 'package:hotel_manager/views/manage_staff/manage_staff_screen.dart';
import 'package:hotel_manager/views/message_screen.dart';
import 'package:hotel_manager/views/review_screen.dart';

class DrawerTile extends StatelessWidget {
  DrawerTile({
    this.icon = Icons.dashboard,
    this.title = 'Dashboard',
    this.colour = ColourConstants.mainBlue,
    this.textColour = ColourConstants.white,
    this.onPressed,
  });

  IconData icon;
  String title;
  Color colour;
  Color textColour;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: colour,
        height: 70,
        child: Row(
          children: [
            Icon(
              icon,
              color: textColour,
              size: 28,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              title,
              style: TextConstants.subTextStyle(color: textColour),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Builder(
        builder: (context) {
          return Container(
            color: Colors.white,
            width: displayWidth * 0.6,
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
            child: Column(
              children: [
                SvgPicture.string(
                  SvgConstants.hotelImage,
                  width: displayWidth * 0.3,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Ceylon Resort',
                  style: TextConstants.subTextStyle(),
                ),
                SizedBox(
                  height: 10,
                ),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 20),
                //   color: ColourConstants.mainBlue,
                //   height: 60,
                //   child: Row(
                //     children: [
                //       Icon(Icons.data_thresholding_outlined, color: Colors.white, size: 28,),
                //       SizedBox(width: 5,),
                //       Text('Dashboard', style: TextConstants.subTextStyle(color: Colors.white), textAlign: TextAlign.left,),
                //     ],
                //   ),
                // ),
                Obx(() {
                  bool isSelected =
                      DrawerStateController.instance.selectedIndex == DrawerStateController.DASHBAORD_INDEX;
                  return DrawerTile(
                    icon: Icons.dashboard_outlined,
                    colour: isSelected
                        ? ColourConstants.mainBlue
                        : Colors.grey.shade100,
                    textColour: isSelected
                        ? ColourConstants.white
                        : ColourConstants.richBlack,
                    onPressed: () {
                      DrawerStateController.instance.selectedIndex = DrawerStateController.DASHBAORD_INDEX;
                      Scaffold.of(context).closeDrawer();
                      Get.to(() => DashboardScreen());
                    },
                  );
                }),
                Obx(() {
                  bool isSelected =
                      DrawerStateController.instance.selectedIndex == DrawerStateController.BOOKINGS_INDEX;
                  return DrawerTile(
                    icon: Icons.bookmark_outline_outlined,
                    title: 'Bookings',
                    colour: isSelected
                        ? ColourConstants.mainBlue
                        : Colors.grey.shade100,
                    textColour: isSelected
                        ? ColourConstants.white
                        : ColourConstants.richBlack,
                    onPressed: () {
                      DrawerStateController.instance.selectedIndex = DrawerStateController.BOOKINGS_INDEX;
                      Scaffold.of(context).closeDrawer();
                      Get.to(() => ManageReservationsScreen());
                    },
                  );
                }),
                Obx(() {
                  bool isSelected =
                      DrawerStateController.instance.selectedIndex == DrawerStateController.REVIEWS_INDEX;
                  return DrawerTile(
                    icon: Icons.rate_review_outlined,
                    title: 'Reviews',
                    colour: isSelected
                        ? ColourConstants.mainBlue
                        : Colors.grey.shade100,
                    textColour: isSelected
                        ? ColourConstants.white
                        : ColourConstants.richBlack,
                    onPressed: () {
                      DrawerStateController.instance.selectedIndex = DrawerStateController.REVIEWS_INDEX;
                      Get.to(() => ReviewScreen());
                    },
                  );
                }),
                Obx(() {
                  bool isSelected =
                      DrawerStateController.instance.selectedIndex == DrawerStateController.MESSAGES_INDEX;
                  return DrawerTile(
                    icon: Icons.message_outlined,
                    title: 'Messages',
                    colour: isSelected
                        ? ColourConstants.mainBlue
                        : Colors.grey.shade100,
                    textColour: isSelected
                        ? ColourConstants.white
                        : ColourConstants.richBlack,
                    onPressed: () {
                      DrawerStateController.instance.selectedIndex = DrawerStateController.MESSAGES_INDEX;
                      Get.to(() => MessageScreen());
                    },
                  );
                }),
                Obx(() {
                  bool isSelected =
                      DrawerStateController.instance.selectedIndex == DrawerStateController.STAFF_INDEX;
                  return DrawerTile(
                    icon: Icons.people_outline_outlined,
                    title: 'Staff',
                    colour: isSelected
                        ? ColourConstants.mainBlue
                        : Colors.grey.shade100,
                    textColour: isSelected
                        ? ColourConstants.white
                        : ColourConstants.richBlack,
                    onPressed: () {
                      DrawerStateController.instance.selectedIndex = DrawerStateController.STAFF_INDEX;
                      Get.to(() => ManageStaffScreen());
                    },
                  );
                }),
                // Obx(() {
                //   bool isSelected =
                //       DrawerStateController.instance.selectedIndex == 4;
                //   return DrawerTile(
                //     icon: Icons.settings_outlined,
                //     title: 'Settings',
                //     colour: isSelected
                //         ? ColourConstants.mainBlue
                //         : Colors.grey.shade100,
                //     textColour: isSelected
                //         ? ColourConstants.white
                //         : ColourConstants.richBlack,
                //     onPressed: () {
                //       DrawerStateController.instance.selectedIndex = 4;
                //       // Get.to(() => DashboardScreen());
                //     },
                //   );
                // }),
                Spacer(),
                ActionButton(
                    btnText: 'Logout',
                    onTap: () async {
                      await AuthController.instance.logout();
                    }),
              ],
            ),
          );
        }
      ),
    );
  }
}
