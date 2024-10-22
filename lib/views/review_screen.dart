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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      DrawerStateController.instance.selectedIndex =
          DrawerStateController.REVIEWS_INDEX;
    });

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
                          await ReviewDataController.instance
                              .reinitController();
                        },
                        child: Obx(
                          () => CustomScrollView(
                            slivers: ReviewDataController.instance.reviewList
                                    .where((review) =>
                                        review.status == ReviewStatus.Pending)
                                    .isNotEmpty
                                ? ReviewDataController.instance.reviewList
                                    .where((review) =>
                                        review.status == ReviewStatus.Pending)
                                    .map((review) {
                                    return SliverList(
                                      delegate: SliverChildListDelegate(
                                        [
                                          ReviewTile(
                                            review: review,
                                            onAcceptTap: () async {
                                              LoadingDialog(
                                                  callerFunction: () async {
                                                await ReviewDataController
                                                    .instance
                                                    .acceptReview(
                                                  tempReviewId: review.id,
                                                );
                                              }, onSuccessCallBack: () {
                                                Get.snackbar(
                                                  'Review accepted successfully',
                                                  'Review was accepted successfully',
                                                  backgroundColor:
                                                      ColourConstants.green1,
                                                  colorText:
                                                      ColourConstants.ivory,
                                                );
                                              }, onErrorCallBack: (e) {
                                                print(e.toString());
                                                MessageDialogBox(message: 'An unexpected error occurred');
                                              });
                                            },
                                            onRejectTap: () {
                                              Get.dialog(
                                                Dialog(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(10.0),
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
                                                              ColourConstants
                                                                  .red1,
                                                          borderWidth: 2.0,
                                                          btnText: 'Yes',
                                                          fontSize: 18,
                                                          onTap: () async {
                                                            //TODO: review remove functionality
                                                            await ReviewDataController
                                                                .instance
                                                                .rejectReview(
                                                                    tempReviewId:
                                                                        review
                                                                            .id);
                                                            Get.back();
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
                                            onAcceptErrorCallBack: (e) {
                                              Get.snackbar(
                                                  'Error', e.toString());
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList()
                                : <Widget>[
                                    SliverFillRemaining(
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Looks like there aren\'t any pending reviews!',
                                              textAlign: TextAlign.center,
                                              style:
                                                  TextConstants.mainTextStyle(
                                                      color: ColourConstants
                                                          .richBlack),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                          ),
                        ),
                      ),
                      RefreshIndicator(
                        onRefresh: () async {
                          await ReviewDataController.instance
                              .reinitController();
                        },
                        child: Obx(
                          () => CustomScrollView(
                            slivers: ReviewDataController.instance.reviewList
                                    .where((review) =>
                                        review.status == ReviewStatus.Approved)
                                    .isNotEmpty
                                ? ReviewDataController.instance.reviewList
                                    .where((review) =>
                                        review.status == ReviewStatus.Approved)
                                    .map((review) {
                                    return SliverList(
                                      delegate: SliverChildListDelegate(
                                        [
                                          ReviewTile(
                                            review: review,
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList()
                                : <Widget>[
                                    SliverFillRemaining(
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Looks like there aren\'t any pending reviews!',
                                              textAlign: TextAlign.center,
                                              style:
                                                  TextConstants.mainTextStyle(
                                                      color: ColourConstants
                                                          .richBlack),
                                            ),
                                          ],
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
