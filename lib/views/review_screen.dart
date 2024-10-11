import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_manager/components/action_button.dart';
import 'package:hotel_manager/components/custom_drawer.dart';
import 'package:hotel_manager/components/loading_dialog.dart';
import 'package:hotel_manager/components/message_dialog_box.dart';
import 'package:hotel_manager/components/review_tile.dart';
import 'package:hotel_manager/constants/colour_constants.dart';
import 'package:hotel_manager/controllers/data/review_data_controller.dart';
import 'package:hotel_manager/controllers/view/drawer_state_controller.dart';
import 'package:hotel_manager/enum/review_status.dart';
import 'package:hotel_manager/models/review.dart';

import '../../constants/text_constants.dart';
import '../controllers/view/review/review_screen_tab_bar_controller.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    double deviceHeight = deviceSize.height;
    double deviceWidth = deviceSize.width;

    return GetBuilder<ReviewScreenTabBarController>(
      init: ReviewScreenTabBarController(),
      builder: (controller) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          drawer: CustomDrawer(),
          backgroundColor: ColourConstants.ivory,
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                          'Customer Reviews',
                          style: TextConstants.mainTextStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Obx(
                    () => TabBar(
                      indicatorColor: Colors.transparent,
                      dividerColor: Colors.transparent,
                      controller: controller.tabController,
                      overlayColor: WidgetStateColor.resolveWith(
                          (_) => Colors.transparent),
                      tabs: <Widget>[
                        Tab(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            height: 60,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: controller.selectedIndex == 0
                                  ? ColourConstants.mainBlue
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'Pending',
                                style: TextConstants.subTextStyle(
                                  color: controller.selectedIndex == 0
                                      ? ColourConstants.ivory
                                      : ColourConstants.richBlack,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            height: 60,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: controller.selectedIndex == 1
                                  ? ColourConstants.mainBlue
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'Accepted',
                                style: TextConstants.subTextStyle(
                                  color: controller.selectedIndex == 1
                                      ? ColourConstants.ivory
                                      : ColourConstants.richBlack,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: controller.tabController,
                    children: [
                      RefreshIndicator(
                        onRefresh: () async {
                          await Future.delayed(Duration(seconds: 1));
                        },
                        child: RefreshIndicator(
                          onRefresh: () async {
                            try {
                              await ReviewDataController.instance
                                  .reinitController();
                            } catch (e) {
                              MessageDialogBox(
                                  message: 'An Unexpected Error Occurred');
                            }
                          },
                          child: SingleChildScrollView(
                            child: Obx(
                              () => Column(
                                children: ReviewDataController
                                    .instance.reviewList
                                    .where((review) =>
                                        review.status == ReviewStatus.Pending)
                                    .toList()
                                    .map<ReviewTile>(
                                      (review) => ReviewTile(
                                        review: review,
                                        onAcceptTap: () async {
                                          LoadingDialog(
                                              callerFunction: () async {
                                            await ReviewDataController.instance
                                                .acceptReview(
                                              tempReviewId: review.id,
                                            );
                                          }, onErrorCallBack: (e) {
                                            print(e.toString());
                                            Get.dialog(
                                              Dialog(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  padding: EdgeInsets.all(20.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                          'An Unexpected Error Occurred'),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      ActionButton(
                                                          btnText: 'OK',
                                                          onTap: () {
                                                            Get.back();
                                                          }),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                          Get.snackbar(
                                            'Review accepted successfully',
                                            'Review was accepted successfully',
                                            backgroundColor:
                                            ColourConstants.green1,
                                            colorText:
                                            ColourConstants.ivory,
                                          );
                                        },
                                        onRejectTap: () {
                                          Get.dialog(
                                            Dialog(
                                              child: Container(
                                                padding: EdgeInsets.all(10.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      'Are you sure you want to reject this review?',
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
                                                      btnText: 'Yes',
                                                      fontSize: 18,
                                                      onTap: () {
                                                        //TODO: review remove functionality
                                                      },
                                                      height: 40,
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    ActionButton(
                                                      outlineMode: true,
                                                      borderColour:
                                                          ColourConstants
                                                              .chineseBlack,
                                                      borderWidth: 2.0,
                                                      btnText: 'No',
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
                                        onAcceptErrorCallBack: (e){
                                          Get.snackbar('Error', e.toString());
                                        },
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      RefreshIndicator(
                        onRefresh: () async {
                          await Future.delayed(Duration(seconds: 1));
                        },
                        child: SingleChildScrollView(
                          child: Obx(
                            () => Column(
                              children: ReviewDataController.instance.reviewList
                                  .where((review) =>
                                      review.status == ReviewStatus.Approved)
                                  .toList()
                                  .map<ReviewTile>(
                                    (review) => ReviewTile(
                                      review: review,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
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
