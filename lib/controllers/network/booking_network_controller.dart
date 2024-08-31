import 'dart:convert';

import 'package:get/get.dart';
import 'package:hotel_manager/constants/network_constants.dart';
import 'package:hotel_manager/enum/review_status.dart';
import 'package:hotel_manager/exception/network_exception.dart';
import 'package:http/http.dart' as http;

class BookingNetworkController extends GetxController {
  static BookingNetworkController instance = Get.find();

  Future<List<Map<String, dynamic>>> getTempBookings() async {
    try {
      var response = await http.get(
        Uri.parse('${NetworkConstants.baseUrl}/api/booking/temp/all'),
      );
      List<dynamic> decoded = jsonDecode(response.body);
      print(decoded);
      return decoded.map<Map<String, dynamic>>((element) {
        Map<String, dynamic> map = element as Map<String, dynamic>;
        return map;
      }).toList();
    } catch (e) {
      throw NetworkException(e.toString());
    }
  }

  Future<List<Map<String, dynamic>>> getAcceptedBookings() async {
    List<Map<String, dynamic>> dataList = [];
    //
    return dataList;
  }

  Future<Map<String, dynamic>> acceptReview({required int tempReviewId}) async {
    Map<String, dynamic> dataMap = {};
    //
    return dataMap;
  }

  Future<void> rejectReview({required int tempReviewId}) async {
    //
  }
}
