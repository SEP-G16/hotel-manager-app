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

import '../../models/form_valid_response.dart';

class AddEmployeeScreen extends StatelessWidget {
  AddEmployeeScreen({super.key}) {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetBuilder<AddEmployeeViewStateController>(
          init: AddEmployeeViewStateController(),
          builder: (controller) {
            return Scaffold(
              backgroundColor: ColourConstants.ivory,
              body: SafeArea(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
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
                            NamedInputField(
                                titleText: 'Name',
                                onChanged: (value) {
                                  controller.name = value;
                                }),

                            //Role Dropdown
                            Obx(
                              () => NamedDropDownButton<String>(
                                titleText: 'Role',
                                value: controller.selectedRole,
                                selectOptionValue: 'Select',
                                onChanged: (String? value) {
                                  controller.selectedRole = value;
                                },
                                itemList: List.generate(
                                  10,
                                  (index) => DropdownMenuItem<String>(
                                    child: Text(
                                      '$index',
                                      style: TextConstants.subTextStyle(),
                                    ),
                                    value: index.toString(),
                                  ),
                                ),
                              ),
                            ),

                            Obx(
                              () => NamedDropDownButton<String>(
                                titleText: 'Gender',
                                value: controller.selectedGender,
                                selectOptionValue: 'Select',
                                onChanged: (String? value) {
                                  controller.selectedGender = value!;
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
                                    firstDate:
                                        DateTime(DateTime.now().year - 100),
                                    lastDate: DateTime.now(),
                                  );
                                  if (selectedDate != null) {
                                    controller.selectedDate = selectedDate;
                                  }
                                },
                                selectedDate: controller.selectedDate,
                              ),
                            ),
                            NamedInputField(
                                titleText: 'Address',
                                onChanged: (value) {
                                  controller.address = value;
                                }),
                            NamedInputField(
                                titleText: 'Phone No.',
                                onChanged: (value) {
                                  controller.phoneNo = value;
                                }),
                            NamedInputField(
                                titleText: 'Email',
                                onChanged: (value) {
                                  controller.email = value;
                                }),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: ActionButton(
                                btnText: 'Add Employee',
                                onTap: () {
                                  FormValidResponse response =
                                      controller.validateForm();
                                  if (!response.formValid) {
                                    Get.dialog(
                                      Dialog(
                                        child: Container(
                                          padding: EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                response.message ??
                                                    'Invalid Form',
                                                style: TextConstants
                                                    .subTextStyle(),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              ActionButton(
                                                outlineMode: true,
                                                borderColour: ColourConstants
                                                    .chineseBlack,
                                                borderWidth: 2.0,
                                                btnText: 'Go Back',
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
                                  } else {
                                    //TODO: controller.addEmployee();
                                  }
                                },
                                width: 200,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
