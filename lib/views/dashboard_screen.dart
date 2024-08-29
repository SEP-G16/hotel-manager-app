import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hotel_manager/components/action_button.dart';
import 'package:hotel_manager/constants/colour_constants.dart';
import 'package:hotel_manager/constants/svg_constants.dart';
import 'package:hotel_manager/constants/text_constants.dart';
import 'package:hotel_manager/views/manage_staff/manage_staff_screen.dart';
import 'package:hotel_manager/views/manage_reservations/manage_reservations_screen.dart';
import 'package:hotel_manager/views/profile_screen.dart';
import 'package:hotel_manager/views/review_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  String greetTextGenerator() {
    String greeting = '';
    int hour = DateTime.now().hour;
    if (hour < 12) {
      greeting = 'Good Morning';
    } else if (hour < 3) {
      greeting = 'Good Afternoon';
    } else {
      greeting = 'Good Evening';
    }
    return greeting;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColourConstants.ivory,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10.0),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${greetTextGenerator()}\n${'Venura'}!', //Add username here
                          style: TextConstants.mainTextStyle(
                              color: ColourConstants.chineseBlack,
                              fontSize: 30),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: (){
                        Get.to(() => ProfileScreen());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: ColourConstants.mainBlue, width: 3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.person_outline_rounded,
                            size: 30,
                            color: ColourConstants.mainBlue,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Time to manage your hotel!',
                      style: TextConstants.mainTextStyle(fontSize: 28),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: SvgPicture.string(SvgConstants.dashboardScreenImage)),
              ActionButton(
                btnText: 'Manage My Staff',
                onTap: () {
                  Get.to(() => ManageStaffScreen());
                },
                width: 250,
                outlineMode: true,
                borderColour: ColourConstants.mainBlue,
                borderWidth: 2.0,
              ),
              SizedBox(
                height: 10,
              ),
              ActionButton(
                btnText: 'Manage Hotel Bookings',
                onTap: () {
                  Get.to(() => ManageReservationsScreen());
                },
                width: 250,
                outlineMode: true,
                borderColour: ColourConstants.mainBlue,
                borderWidth: 2.0,
              ),
              SizedBox(
                height: 10,
              ),
              ActionButton(
                btnText: 'Manage Customer Reviews',
                onTap: () {
                  Get.to(() => ReviewScreen());
                },
                width: 250,
                outlineMode: true,
                borderColour: ColourConstants.mainBlue,
                borderWidth: 2.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
