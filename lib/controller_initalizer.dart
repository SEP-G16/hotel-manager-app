import 'package:get/get.dart';
import 'package:hotel_manager/controllers/data/auth_controller.dart';
import 'package:hotel_manager/controllers/data/booking_data_controller.dart';
import 'package:hotel_manager/controllers/data/customer_message_data_controller.dart';
import 'package:hotel_manager/controllers/data/review_data_controller.dart';
import 'package:hotel_manager/controllers/data/secure_storage_controller.dart';
import 'package:hotel_manager/controllers/network/auth_network_controller.dart';
import 'package:hotel_manager/controllers/network/booking_network_controller.dart';
import 'package:hotel_manager/controllers/network/customer_message_network_controller.dart';
import 'package:hotel_manager/controllers/network/review_network_controller.dart';
import 'package:hotel_manager/controllers/network/staff_network_controller.dart';
import 'package:hotel_manager/controllers/view/dashboard_state_controller.dart';
import 'package:hotel_manager/controllers/view/drawer_state_controller.dart';

import 'controllers/data/staff_data_controller.dart';

class ControllerInitializer{

  ControllerInitializer._();

  static bool initialised = false;

  static Future<void> initController() async
  {
    try{
      Get.put(BookingNetworkController());
      await Get.putAsync(() => BookingDataController.create());
      Get.put(ReviewNetworkController());
      await Get.putAsync(() => ReviewDataController.create());
      Get.put(StaffNetworkController());
      await Get.putAsync(() => StaffDataController.create());
      Get.put(CustomerMessageNetworkController());
      await Get.putAsync(() => CustomerMessageDataController.create());
      Get.put(DrawerStateController());
      Get.put(DashboardStateController());
    }catch(e){
      print(e.toString());
      rethrow;
    }
  }
}