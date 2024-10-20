import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hotel_manager/components/action_button.dart';
import 'package:hotel_manager/components/custom_drawer.dart';
import 'package:hotel_manager/components/input_field.dart';
import 'package:hotel_manager/components/loading_dialog.dart';
import 'package:hotel_manager/components/message_dialog_box.dart';
import 'package:hotel_manager/components/message_tile.dart';
import 'package:hotel_manager/components/review_tile.dart';
import 'package:hotel_manager/constants/colour_constants.dart';
import 'package:hotel_manager/controllers/data/review_data_controller.dart';
import 'package:hotel_manager/controllers/view/drawer_state_controller.dart';
import 'package:hotel_manager/controllers/view/message/message_screen_state_controller.dart';
import 'package:hotel_manager/controllers/view/message/message_state_controller.dart';
import 'package:hotel_manager/controllers/view/staff/manage_staff_screen_state_controller.dart';
import 'package:hotel_manager/enum/review_status.dart';
import 'package:hotel_manager/models/review.dart';
import 'package:hotel_manager/models/support_ticket.dart';
import 'package:intl/intl.dart';

import '../../constants/text_constants.dart';
import '../constants/svg_constants.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_){
      DrawerStateController.instance.selectedIndex = DrawerStateController.MESSAGES_INDEX;
    });


    Get.put(MessageScreenStateController());
    Size deviceSize = MediaQuery.of(context).size;
    double deviceHeight = deviceSize.height;
    double deviceWidth = deviceSize.width;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
                        'Messages',
                        style: TextConstants.mainTextStyle(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await MessageScreenStateController.instance
                        .getSupportTickets();
                  },
                  child: Obx(
                    () => CustomScrollView(
                      slivers: MessageScreenStateController
                              .instance.ticketList.isNotEmpty
                          ? MessageScreenStateController.instance.ticketList
                              .map((ticket) {
                              final controller = Get.put(
                                  MessageStateController(),
                                  tag: ticket.id.toString());
                              return SliverList(
                                delegate: SliverChildListDelegate(
                                  [
                                    MessageTile(
                                      ticket: ticket,
                                      onChanged: (value) {
                                        controller.message = value;
                                      },
                                      onSendTap: () async {
                                        if (controller.message == null ||
                                            controller.message!.isEmpty) {
                                          MessageDialogBox(
                                              message:
                                                  'You cannot send an empty message');
                                          return;
                                        }
                                        await controller.sendMessage(ticket.id);
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
                                        'Nothing to see here! Drag Down to Refresh!',
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
            ],
          ),
        ),
      ),
    );
  }
}
