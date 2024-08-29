import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_manager/components/action_button.dart';
import 'package:hotel_manager/components/custom_drop_down_button.dart';
import 'package:hotel_manager/components/named_date_input_field.dart';
import 'package:hotel_manager/components/named_drop_down_button.dart';
import 'package:hotel_manager/constants/colour_constants.dart';
import 'package:hotel_manager/controllers/view/add_employee_view_state_controller.dart';
import 'package:intl/intl.dart';

import '../../components/named_input_field.dart';
import '../../constants/svg_constants.dart';
import '../../constants/text_constants.dart';

import 'package:get/get.dart';

class AddEmployeeScreen extends StatelessWidget {
  AddEmployeeScreen({super.key}) {
    Get.put(AddEmployeeViewStateController());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
                        'Add Staff Member',
                        style: TextConstants.mainTextStyle(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Stack(
                      //   alignment: Alignment.center,
                      //   children: [
                      //     CircleAvatar(
                      //       radius: 80,
                      //       backgroundColor: ColourConstants.mainBlue,
                      //       child: CircleAvatar(
                      //         radius: 75,
                      //         child: SvgPicture.string(
                      //           SvgConstants.avatarImage,
                      //         ),
                      //       ),
                      //     ),
                      //     Positioned(
                      //       bottom: 0,
                      //       right: 10,
                      //       child: GestureDetector(
                      //         onTap: () {},
                      //         child: CircleAvatar(
                      //           radius: 20,
                      //           backgroundColor: ColourConstants.mainBlue,
                      //           child: Icon(
                      //             Icons.add,
                      //             color: Colors.white,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      NamedInputField(titleText: 'Name', onChanged: (value) {}),

                      //Role Dropdown
                      Obx(
                        () => NamedDropDownButton(
                          titleText: 'Role',
                          value: AddEmployeeViewStateController
                              .instance.selectedValue,
                          selectOptionValue: -1,
                          onChanged: (value) {
                            AddEmployeeViewStateController
                                .instance.selectedValue = value;
                          },
                          itemList: List.generate(
                            10,
                            (index) => DropdownMenuItem(
                              child: Text(
                                '$index',
                                style: TextConstants.subTextStyle(),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Obx(
                        () => NamedDropDownButton(
                          titleText: 'Gender',
                          value: AddEmployeeViewStateController
                              .instance.selectedGender,
                          selectOptionValue: 'Select',
                          onChanged: (value) {
                            AddEmployeeViewStateController
                                .instance.selectedGender = value;
                          },
                          itemList: ['Male', 'Female']
                              .map<DropdownMenuItem<String>>(
                                (gender) => DropdownMenuItem(
                                  value: gender,
                                  child: Text(
                                    gender,
                                    style: TextConstants.subTextStyle(),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),

                      Obx(
                        () => NamedDateInputField(
                          titleText: 'Date of Birth',
                          onPressed: () async {
                            DateTime? selectedDate = await showDatePicker(
                              context: context,
                              firstDate: DateTime(DateTime.now().year - 100),
                              lastDate: DateTime.now(),
                            );
                            if (selectedDate != null) {
                              AddEmployeeViewStateController
                                  .instance.selectedDate = selectedDate;
                            }
                          },
                          selectedDate: AddEmployeeViewStateController
                              .instance.selectedDate,
                        ),
                      ),
                      NamedInputField(
                          titleText: 'Address', onChanged: (value) {}),
                      NamedInputField(
                          titleText: 'Phone No.', onChanged: (value) {}),
                      NamedInputField(titleText: 'Email', onChanged: (value) {}),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child:
                            ActionButton(btnText: 'Add Employee', onTap: () {}),
                      ),
                    ],
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
