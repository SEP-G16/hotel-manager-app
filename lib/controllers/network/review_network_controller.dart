import 'dart:convert';

import 'package:get/get.dart';
import 'package:hotel_manager/constants/network_constants.dart';
import 'package:hotel_manager/enum/review_status.dart';
import 'package:hotel_manager/exception/network_exception.dart';
import 'package:http/http.dart' as http;

class ReviewNetworkController extends GetxController {
  static ReviewNetworkController instance = Get.find();

  Future<List<Map<String, dynamic>>> getTempReviews() async {
    try {
      var response = await http.get(
        Uri.parse('${NetworkConstants.baseUrl}/api/review/temp/all'),
      );
      List<dynamic> decoded = jsonDecode(response.body);
      print(decoded);
      return decoded.map<Map<String, dynamic>>((element) {
        Map<String, dynamic> map = element as Map<String, dynamic>;
        map['createdAt'] = map['date'];
        map['status'] = ReviewStatus.Pending;
        return map;
      }).toList();
    } catch (e) {
      throw NetworkException(e.toString());
    }
  }

  Future<List<Map<String, dynamic>>> getAcceptedReviews() async {
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
