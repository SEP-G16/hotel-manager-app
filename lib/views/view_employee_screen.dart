import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hotel_manager/constants/colour_constants.dart';
import 'package:hotel_manager/controllers/view/view_employee_screen_state_controller.dart';
import 'package:hotel_manager/models/employee.dart';
import 'package:intl/intl.dart';

import '../components/action_button.dart';
import '../components/named_date_input_field.dart';
import '../components/named_drop_down_button.dart';
import '../components/named_input_field.dart';
import '../constants/svg_constants.dart';
import '../constants/text_constants.dart';

/// Screen for viewing employee info
/// Required Arguments
///   employee : Employee
class ViewEmployeeScreen extends StatelessWidget {
  ViewEmployeeScreen(
      // {required this.employee}
      );

  final Employee employee = Employee(
      id: 1,
      name: 'John Smith',
      role: 'Assistant Manager',
      gender: 'Male',
      dateOfBirth: DateTime(2001, 6, 19),
      address: '16, Willow Street, Manchester, London',
      phoneNo: '0123456789',
      email: 'johnsmith@example.com');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: ColourConstants.ivory,
        body: SafeArea(
          child: GetBuilder<ViewEmployeeScreenStateController>(
            init: ViewEmployeeScreenStateController(employee: employee),
            builder: (controller) => Column(
              children: [
                //Custom App Bar
                Obx(
                  () => Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Visibility(
                          visible: !controller.editMode,
                          child: Align(
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
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            controller.editMode ? 'Edit Info' : 'Info',
                            style: TextConstants.mainTextStyle(),
                          ),
                        ),
                        Visibility(
                          visible: !controller.editMode,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                controller.editMode = true;
                              },
                              child: Icon(
                                Icons.edit,
                                color: ColourConstants.mainBlue,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              radius: 80,
                              backgroundColor: ColourConstants.mainBlue,
                              child: CircleAvatar(
                                radius: 75,
                                child: SvgPicture.string(
                                  SvgConstants.avatarImage,
                                ),
                              ),
                            ),

                            //Add if functionality is required

                            // Positioned(
                            //   bottom: 0,
                            //   right: 10,
                            //   child: GestureDetector(
                            //     onTap: () {},
                            //     child: CircleAvatar(
                            //       radius: 20,
                            //       backgroundColor: ColourConstants.mainBlue,
                            //       child: Icon(
                            //         Icons.edit,
                            //         color: Colors.white,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        Obx(
                          () => NamedInputField(
                            titleText: 'Name',
                            onChanged: (value) {
                              controller.name = value;
                            },
                            initialValue: controller.name,
                            readOnly: !controller.editMode,
                          ),
                        ),

                        //Role Dropdown
                        Obx(
                          () {
                            bool editMode = controller.editMode;
                            return editMode
                                ? NamedDropDownButton(
                                    titleText: 'Role',
                                    value: 1,
                                    selectOptionValue: 1,
                                    onChanged: (value) {},
                                    itemList: List.generate(
                                      10,
                                      (index) => DropdownMenuItem(
                                        child: Text(
                                          '$index',
                                          style: TextConstants.subTextStyle(),
                                        ),
                                      ),
                                    ),
                                  )
                                : NamedInputField(
                                    titleText: 'Role',
                                    onChanged: (value) {},
                                    initialValue: employee.role,
                                    readOnly: true,
                                  );
                          },
                        ),

                        Obx(
                          () {
                            if (controller.editMode) {
                              return NamedDropDownButton(
                                titleText: 'Gender',
                                value: '',
                                selectOptionValue: '',
                                onChanged: (value) {},
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
                              );
                            } else {
                              return NamedInputField(
                                titleText: 'Gender',
                                onChanged: (value) {},
                                initialValue:
                                    employee.gender,
                                readOnly: true,
                              );
                            }
                          },
                        ),

                        Obx(
                          () {
                            if (controller.editMode) {
                              return NamedDateInputField(
                                titleText: 'Date of Birth',
                                onPressed: () async {
                                  DateTime? selectedDate = await showDatePicker(
                                    context: context,
                                    firstDate:
                                        DateTime(DateTime.now().year - 100),
                                    lastDate: DateTime.now(),
                                  );
                                  if (selectedDate != null) {
                                    //Add date change logic here with the controller
                                  }
                                },
                                selectedDate: employee.dateOfBirth,
                              );
                            } else {
                              return NamedInputField(
                                titleText: 'Date of Birth',
                                onChanged: (value) {},
                                initialValue: DateFormat('yyyy/MM/dd')
                                    .format(employee.dateOfBirth),
                              );
                            }
                          },
                        ),
                        Obx(
                          () => NamedInputField(
                            titleText: 'Address',
                            onChanged: (value) {},
                            initialValue: employee.address,
                            readOnly: !controller.editMode,
                          ),
                        ),
                        Obx(
                          () => NamedInputField(
                            titleText: 'Phone No.',
                            onChanged: (value) {},
                            initialValue: employee.phoneNo,
                            readOnly: !controller.editMode,
                          ),
                        ),
                        Obx(
                          () => NamedInputField(
                            titleText: 'Email',
                            onChanged: (value) {},
                            initialValue: employee.email,
                            readOnly: !controller.editMode,
                          ),
                        ),
                        Obx(
                          () => Visibility(
                            visible: controller.editMode,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child:
                                  ActionButton(btnText: 'Save', onTap: () {}),
                            ),
                          ),
                        ),
                      ],
                    ),
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
