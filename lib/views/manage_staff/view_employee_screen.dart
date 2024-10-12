import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hotel_manager/components/loading_dialog.dart';
import 'package:hotel_manager/components/message_dialog_box.dart';
import 'package:hotel_manager/constants/colour_constants.dart';
import 'package:hotel_manager/controllers/view/staff/view_employee_screen_state_controller.dart';
import 'package:hotel_manager/enum/gender.dart';
import 'package:hotel_manager/models/employee.dart';
import 'package:hotel_manager/models/form_valid_response.dart';
import 'package:hotel_manager/views/manage_staff/manage_staff_screen.dart';
import 'package:intl/intl.dart';

import '../../components/action_button.dart';
import '../../components/named_date_input_field.dart';
import '../../components/named_drop_down_button.dart';
import '../../components/named_input_field.dart';
import '../../constants/svg_constants.dart';
import '../../constants/text_constants.dart';

/// Screen for viewing employee info
/// Required Arguments
///   employee : Employee
class ViewEmployeeScreen extends StatelessWidget {
  ViewEmployeeScreen({required this.employee});

  final Employee employee;

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
                        //
                        //     //Add if functionality is required
                        //
                        //     // Positioned(
                        //     //   bottom: 0,
                        //     //   right: 10,
                        //     //   child: GestureDetector(
                        //     //     onTap: () {},
                        //     //     child: CircleAvatar(
                        //     //       radius: 20,
                        //     //       backgroundColor: ColourConstants.mainBlue,
                        //     //       child: Icon(
                        //     //         Icons.edit,
                        //     //         color: Colors.white,
                        //     //       ),
                        //     //     ),
                        //     //   ),
                        //     // ),
                        //   ],
                        // ),
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
                                    value: controller.role,
                                    selectOptionValue: '',
                                    onChanged: (value) {
                                      controller.role = value;
                                    },
                                    itemList: controller.roles
                                        .map<DropdownMenuItem<String>>(
                                          (role) => DropdownMenuItem(
                                            value: role.name,
                                            child: Text(
                                              role.name,
                                              style:
                                                  TextConstants.subTextStyle(),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  )
                                : NamedInputField(
                                    titleText: 'Role',
                                    onChanged: (value) {},
                                    initialValue: controller.role,
                                    readOnly: true,
                                  );
                          },
                        ),

                        Obx(
                          () {
                            if (controller.editMode) {
                              return NamedDropDownButton(
                                titleText: 'Gender',
                                value: controller.gender,
                                selectOptionValue: '',
                                onChanged: (value) {
                                  controller.gender = value;
                                },
                                itemList: Gender.values
                                    .map<DropdownMenuItem<String>>(
                                      (gender) => DropdownMenuItem(
                                        value: gender.name,
                                        child: Text(
                                          gender.name,
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
                                initialValue: controller.gender,
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
                                    controller.dateOfBirth = selectedDate;
                                  }
                                },
                                selectedDate: employee.dateOfBirth,
                              );
                            } else {
                              return NamedInputField(
                                titleText: 'Date of Birth',
                                onChanged: (value) {},
                                initialValue: DateFormat('yyyy/MM/dd')
                                    .format(controller.dateOfBirth!),
                              );
                            }
                          },
                        ),
                        Obx(
                          () => NamedInputField(
                            titleText: 'Address',
                            onChanged: (value) {
                              controller.address = value;
                            },
                            initialValue: employee.address,
                            readOnly: !controller.editMode,
                          ),
                        ),
                        Obx(
                          () => NamedInputField(
                            titleText: 'Phone No.',
                            onChanged: (value) {
                              controller.phoneNo = value;
                            },
                            initialValue: employee.phoneNumber,
                            readOnly: !controller.editMode,
                          ),
                        ),
                        Obx(
                          () => NamedInputField(
                            titleText: 'Email',
                            onChanged: (value) {
                              controller.email = value;
                            },
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
                              child: ActionButton(
                                btnText: 'Save',
                                onTap: () {
                                  FormValidResponse response =
                                      controller.validateForm();
                                  if (!response.formValid) {
                                    MessageDialogBox(
                                        message:
                                            response.message ?? 'Invalid Form',
                                        btnText: 'Go Back');
                                  } else {
                                    LoadingDialog(callerFunction: () async {
                                      await controller.updateEmployee(
                                          employeeId: employee.id);
                                    }, onSuccessCallBack: () {
                                      Get.to(() => ManageStaffScreen());
                                      Get.snackbar('Success',
                                          'Employee updated successfully', backgroundColor: ColourConstants.green1, colorText: ColourConstants.ivory);
                                    }, onErrorCallBack: (error) {
                                      Exception e = error as Exception;
                                      Get.snackbar('Error',
                                          'An unexpected error occurred while updating employee');
                                      throw e;
                                    });
                                    controller.editMode = false;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
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
