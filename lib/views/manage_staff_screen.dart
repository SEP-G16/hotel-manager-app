import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_manager/components/action_button.dart';
import 'package:hotel_manager/components/review_tile.dart';
import 'package:hotel_manager/components/staff_tile.dart';
import 'package:hotel_manager/constants/svg_constants.dart';

import '../constants/colour_constants.dart';
import '../constants/text_constants.dart';

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
                    (_) => StaffTile(
                      name: 'Emily Smith',
                      role: 'Ast. Manager',
                      phoneNo: '0771234567',
                      onInfoPressed: () {},
                      onFirePressed: () {},
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: ActionButton(
                btnText: 'Add Employee',
                onTap: () {},
                width: 180,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
