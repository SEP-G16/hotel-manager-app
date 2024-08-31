import 'package:get/get.dart';
import 'package:hotel_manager/controllers/data/booking_data_controller.dart';
import 'package:hotel_manager/controllers/data/review_data_controller.dart';
import 'package:hotel_manager/controllers/network/booking_network_controller.dart';
import 'package:hotel_manager/controllers/network/review_network_controller.dart';

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
    }catch(e){
      print(e.toString());
      rethrow;
    }
  }
}