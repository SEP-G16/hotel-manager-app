import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hotel_manager/components/action_button.dart';
import 'package:hotel_manager/components/review_tile.dart';
import 'package:hotel_manager/components/staff_tile.dart';
import 'package:hotel_manager/constants/svg_constants.dart';
import 'package:hotel_manager/models/employee.dart';
import 'package:hotel_manager/views/manage_staff/add_employee_screen.dart';
import 'package:hotel_manager/views/manage_staff/view_employee_screen.dart';

import '../../constants/colour_constants.dart';
import '../../constants/text_constants.dart';

class ManageStaffScreen extends StatelessWidget {
  const ManageStaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'Manage My Staff',
                      style: TextConstants.mainTextStyle(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(30.0),
                border: Border.all(color: ColourConstants.mainBlue, width: 3),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        label: Text(
                          'Search Here',
                          style: TextConstants.subTextStyle(
                            fontSize: 18,
                            color: ColourConstants.richBlack.withOpacity(
                              0.7,
                            ),
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 5.0,
                        ),
                        isDense: true,
                        isCollapsed: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        floatingLabelStyle:
                            TextStyle(color: Colors.transparent),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.search,
                    size: 30,
                    color: ColourConstants.mainBlue,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    10,
                    (_) => Employee(
                      id: _,
                      name: 'Emily Smith',
                      role: 'Assistant Manager',
                      gender: 'Female',
                      dateOfBirth:
                          DateTime.now().subtract(Duration(days: 365 * 20)),
                      address: '16, Willow Street, Manchester, UK',
                      phoneNo: '0776551234',
                      email: 'emilys@example.com',
                    ),
                  )
                      .map<Widget>(
                        (employee) => StaffTile(
                          name: employee.name,
                          role: employee.role,
                          phoneNo: employee.phoneNo,
                          onInfoPressed: () {
                            Get.to(
                                () => ViewEmployeeScreen(employee: employee));
                          },
                          onFirePressed: () {
                            Get.dialog(
                              Dialog(
                                child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Are you sure you want to fire ${employee.name}?',
                                        style: TextConstants.subTextStyle(),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ActionButton(
                                        outlineMode: true,
                                        borderColour: ColourConstants.red1,
                                        borderWidth: 2.0,
                                        btnText: 'Fire Employee',
                                        fontSize: 18,
                                        onTap: () {
                                          //TODO: employee remove functionality
                                        },
                                        height: 40,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      ActionButton(
                                        outlineMode: true,
                                        borderColour:
                                            ColourConstants.chineseBlack,
                                        borderWidth: 2.0,
                                        btnText: 'Cancel',
                                        fontSize: 18,
                                        height: 40,
                                        onTap: () {
                                          Get.back();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: ActionButton(
                btnText: 'Add Employee',
                onTap: () => Get.to(() => AddEmployeeScreen()),
                outlineMode: true,
                borderWidth: 2.0,
                width: 180,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
