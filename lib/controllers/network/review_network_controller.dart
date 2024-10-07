import 'dart:convert';

import 'package:get/get.dart';
import 'package:hotel_manager/constants/network_constants.dart';
import 'package:hotel_manager/controllers/data/auth_controller.dart';
import 'package:hotel_manager/enum/review_status.dart';
import 'package:hotel_manager/exception/network_exception.dart';
import 'package:hotel_manager/exception/token_expired_exception.dart';
import 'package:hotel_manager/exception/token_not_found_exception.dart';
import 'package:hotel_manager/exception/unauthorized_exception.dart';
import 'package:http/http.dart' as http;

class ReviewNetworkController extends GetxController {

  final AuthController _authController = AuthController.instance;

  static ReviewNetworkController instance = Get.find();

  Future<List<Map<String, dynamic>>> getReviews() async {

    if(_authController.token == null){
      throw TokenNotFoundException('Token not found');
    }

    try {
      var response = await http.get(
        Uri.parse('${NetworkConstants.baseUrl}/api/review/all'),
        headers: {
          'Authorization': 'Bearer ${_authController.token!}',
        },
      );

      if(response.statusCode == 401){
        await _authController.logout();
        throw TokenExpiredException('Token expired');
      }

      if(response.statusCode != 200){
        throw NetworkException('Failed to fetch reviews');
      }

      List<dynamic> decoded = jsonDecode(response.body);
      return decoded.map<Map<String, dynamic>>((element) {
        Map<String, dynamic> map = element as Map<String, dynamic>;
        // map['createdAt'] = map['date'];
        // map['status'] = ReviewStatus.Pending;
        return map;
      }).toList();
    } on FormatException catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> acceptReview({required int tempReviewId}) async {
    if(_authController.token == null){
      throw TokenNotFoundException('Token not found');
    }

    try {
      var response = await http.put(
        Uri.parse('${NetworkConstants.baseUrl}/api/review/accept/$tempReviewId'),
        headers: {
          'Authorization': 'Bearer ${_authController.token!}',
        },
      );

      if(response.statusCode == 401){
        await _authController.logout();
        throw TokenExpiredException('Token expired');
      }

      if(!(response.statusCode >= 200 && response.statusCode < 300)){
        throw NetworkException('Failed to accept review');
      }

      return jsonDecode(response.body);
    } on FormatException catch (e) {
      rethrow;
    }
  }

  Future<void> rejectReview({required int tempReviewId}) async {
    if(_authController.token == null){
      throw TokenNotFoundException('Token not found');
    }

    try {
      var response = await http.put(
        Uri.parse('${NetworkConstants.baseUrl}/api/review/reject/$tempReviewId'),
        headers: {
          'Authorization': 'Bearer ${_authController.token!}',
        },
      );

      if(response.statusCode == 401){
        await _authController.logout();
        throw TokenExpiredException('Token expired');
      }

      if(!(response.statusCode >= 200 && response.statusCode < 300)){
        throw NetworkException('Failed to reject review');
      }
    } on FormatException catch (e) {
      rethrow;
    }
  }
}
