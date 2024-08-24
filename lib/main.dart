import 'package:flutter/material.dart';
import 'package:hotel_manager/constants/colour_constants.dart';
import 'package:hotel_manager/views/add_employee_screen.dart';
import 'package:get/get.dart';
import 'package:hotel_manager/views/add_reservation.dart';
import 'package:hotel_manager/views/temp_reservation_details.dart';
import 'package:hotel_manager/views/booking_tab_screen.dart';


// Initial comment
void main() {
  runApp(const HotelManager());
}

class HotelManager extends StatelessWidget {
  const HotelManager({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.light(primary: ColourConstants.mainBlue),
        useMaterial3: true,
      ),
      home: BookingTabScreen(),
    );
  }
}
