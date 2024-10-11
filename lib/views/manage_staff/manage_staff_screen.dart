import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hotel_manager/components/action_button.dart';
import 'package:hotel_manager/components/custom_drawer.dart';
import 'package:hotel_manager/components/loading_dialog.dart';
import 'package:hotel_manager/components/review_tile.dart';
import 'package:hotel_manager/components/staff_tile.dart';
import 'package:hotel_manager/constants/svg_constants.dart';
import 'package:hotel_manager/controllers/data/staff_data_controller.dart';
import 'package:hotel_manager/controllers/view/drawer_state_controller.dart';
import 'package:hotel_manager/controllers/view/staff/manage_staff_screen_state_controller.dart';
import 'package:hotel_manager/enum/gender.dart';
import 'package:hotel_manager/models/employee.dart';
import 'package:hotel_manager/models/role.dart';
import 'package:hotel_manager/views/manage_staff/add_employee_screen.dart';
import 'package:hotel_manager/views/manage_staff/view_employee_screen.dart';

import '../../constants/colour_constants.dart';
import '../../constants/text_constants.dart';

class ManageStaffScreen extends StatelessWidget {
  const ManageStaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ManageStaffScreenStateController());
    return Scaffold(
      drawer: CustomDrawer(),
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
                    child: Builder(builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: Icon(
                          Icons.menu_rounded,
                          color: ColourConstants.richBlack,
                          size: 30,
                        ),
                      );
                    }),
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
            Row(
              children: [
                Expanded(
                  child: SearchAnchor(builder: (context, controller) {
                    return SearchBar(
                      onChanged: (value) {
                        ManageStaffScreenStateController.instance
                            .handleSearchTextChange(value);
                      },
                      leading: IconButton(
                        icon: Icon(
                          Icons.search_rounded,
                          color: ColourConstants.mainBlue,
                        ),
                        onPressed: () {},
                      ),
                      hintText: 'Enter Name or Phone No.',
                      hintStyle: WidgetStateTextStyle.resolveWith(
                        (_) => TextConstants.subTextStyle(
                          fontSize: 16,
                          color: ColourConstants.chineseBlack.withOpacity(0.4),
                        ),
                      ),
                      textStyle: WidgetStateTextStyle.resolveWith(
                        (_) => TextConstants.subTextStyle(
                          fontSize: 16,
                          color: ColourConstants.chineseBlack,
                        ),
                      ),
                    );
                  }, suggestionsBuilder: (context, controller) {
                    return [];
                  }),
                ),
              ],
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await StaffDataController.instance.reInitController();
                },
                child: Obx(
                  () => CustomScrollView(
                    slivers: ManageStaffScreenStateController
                            .instance.displayedEmployeeList.isNotEmpty
                        ? ManageStaffScreenStateController
                            .instance.displayedEmployeeList
                            .map((employee) {
                            return SliverList(
                              delegate: SliverChildListDelegate(
                                [
                                  StaffTile(
                                    employee: employee,
                                    onInfoPressed: () {
                                      Get.to(() => ViewEmployeeScreen(
                                          employee: employee));
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
                                                  style: TextConstants
                                                      .subTextStyle(),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                ActionButton(
                                                  outlineMode: true,
                                                  borderColour:
                                                      ColourConstants.red1,
                                                  borderWidth: 2.0,
                                                  btnText: 'Fire Employee',
                                                  fontSize: 18,
                                                  onTap: () {
                                                    Get.back(); //close dialog
                                                    //TODO: employee remove functionality
                                                    LoadingDialog(
                                                      callerFunction: () async {
                                                        await ManageStaffScreenStateController
                                                            .instance
                                                            .fireEmployee(
                                                                employee.id);
                                                      },
                                                      onSuccessCallBack: () {
                                                        Get.snackbar('Success',
                                                            'Employee has been fired successfully',
                                                            backgroundColor:
                                                                ColourConstants
                                                                    .green1,
                                                            colorText:
                                                                ColourConstants
                                                                    .ivory);
                                                      },
                                                      onErrorCallBack: (error) {
                                                        print(error.toString());
                                                        Get.snackbar('Error',
                                                            'An error occurred while firing the employee',
                                                            backgroundColor:
                                                                ColourConstants
                                                                    .red1,
                                                            colorText:
                                                                ColourConstants
                                                                    .ivory);
                                                      },
                                                    );
                                                  },
                                                  height: 40,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                ActionButton(
                                                  outlineMode: true,
                                                  borderColour: ColourConstants
                                                      .chineseBlack,
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
                                ],
                              ),
                            );
                          }).toList()
                        : <Widget>[
                            SliverFillRemaining(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Looks like no one has been added yet!',
                                      textAlign: TextAlign.center,
                                      style: TextConstants.mainTextStyle(
                                          color: ColourConstants.richBlack),
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
