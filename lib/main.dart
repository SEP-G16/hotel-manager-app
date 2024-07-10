import 'package:flutter/material.dart';
import 'package:hotel_manager/views/add_employee_screen.dart';
import 'package:hotel_manager/views/loading_screen.dart';
import 'package:hotel_manager/views/login_screen.dart';
import 'package:hotel_manager/views/manage_staff_screen.dart';
import 'package:hotel_manager/views/profile_screen.dart';
import 'package:hotel_manager/views/reviews_screen.dart';

void main() {
  runApp(const HotelManager());
}

class HotelManager extends StatelessWidget {
  const HotelManager({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AddEmployeeScreen(),
    );
  }
}

