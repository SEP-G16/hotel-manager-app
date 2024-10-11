import 'dart:convert';

import 'package:get/get.dart';
import 'package:hotel_manager/constants/network_constants.dart';
import 'package:hotel_manager/controllers/data/auth_controller.dart';
import 'package:hotel_manager/enum/review_status.dart';
import 'package:hotel_manager/exception/network_exception.dart';
import 'package:hotel_manager/exception/token_expired_exception.dart';
import 'package:hotel_manager/exception/unauthorized_exception.dart';
import 'package:http/http.dart' as http;

import '../../enum/room_type.dart';
import '../../exception/token_not_found_exception.dart';

class BookingNetworkController extends GetxController {
  final AuthController _authController = AuthController.instance;

  static BookingNetworkController instance = Get.find();

  Future<List<Map<String, dynamic>>> getTempBookings() async {
    if (_authController.token == null) {
      throw TokenNotFoundException('Token not found');
    }

    try {
      var response = await http.get(
        Uri.parse('${NetworkConstants.baseUrl}/api/booking/temp/all'),
        headers: {
          'Authorization': 'Bearer ${_authController.token!}',
        },
      );

      if (response.statusCode == 401) {
        await _authController.logout();
        throw TokenExpiredException('Token expired');
      }

      if (response.statusCode != 200) {
        throw NetworkException('Failed to fetch temp bookings');
      }
      List<dynamic> decoded = jsonDecode(response.body);
      return decoded.map<Map<String, dynamic>>((element) {
        Map<String, dynamic> map = element as Map<String, dynamic>;
        return map;
      }).toList();
    } on FormatException catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getAcceptedBookings() async {
    if (_authController.token == null) {
      throw TokenNotFoundException('Token not found');
    }

    try {
      var response = await http.get(
        Uri.parse('${NetworkConstants.baseUrl}/api/booking/all'),
        headers: {
          'Authorization': 'Bearer ${_authController.token!}',
        },
      );

      if (response.statusCode == 401) {
        await _authController.logout();
        throw TokenExpiredException('Token expired');
      }

      if (response.statusCode != 200) {
        print(response.body);
        throw NetworkException('Failed to fetch temp bookings');
      }
      List<dynamic> decoded = jsonDecode(response.body);
      print(decoded);
      return decoded.map<Map<String, dynamic>>((element) {
        Map<String, dynamic> map = element as Map<String, dynamic>;
        return map;
      }).toList();
    } on FormatException catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getAvailableRoomCount(
      {required DateTime from, required DateTime to}) async {
    if (_authController.token == null) {
      throw TokenNotFoundException('Token not found');
    }

    try {
      var response = await http.get(
        Uri.parse(
            '${NetworkConstants.baseUrl}/api/room-type/available-count?from=${from.toIso8601String().split('T').first}&to=${to.toIso8601String().split('T').first}'),
        headers: {
          'Authorization': 'Bearer ${_authController.token!}',
        },
      );

      if (response.statusCode == 401) {
        await _authController.logout();
        throw TokenExpiredException('Token expired');
      }

      if (response.statusCode != 200) {
        print(response.body);
        throw NetworkException('Failed to fetch temp bookings');
      }
      List<dynamic> decoded = jsonDecode(response.body);
      print(decoded);
      return decoded.map<Map<String, dynamic>>((element) {
        Map<String, dynamic> map = element as Map<String, dynamic>;
        return map;
      }).toList();
    } on FormatException catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getAvailableRoomsList(
      {required DateTime from,
      required DateTime to,
      required RoomType roomType}) async {
    if (_authController.token == null) {
      throw TokenNotFoundException('Token not found');
    }

    try {
      var response = await http.get(
        Uri.parse(
            '${NetworkConstants.baseUrl}/api/room/available-rooms?from=${from.toIso8601String().split('T').first}&to=${to.toIso8601String().split('T').first}&roomTypeId=${roomType.getTypeId()}'),
        headers: {
          'Authorization': 'Bearer ${_authController.token!}',
        },
      );

      if (response.statusCode == 401) {
        await _authController.logout();
        throw TokenExpiredException('Token expired');
      }

      if (response.statusCode != 200) {
        throw NetworkException('Failed to fetch available room count');
      }
      List<dynamic> decoded = jsonDecode(response.body);
      print(decoded);
      return decoded.map<Map<String, dynamic>>((element) {
        Map<String, dynamic> map = element as Map<String, dynamic>;
        return map;
      }).toList();
    } on FormatException catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> acceptReview({required int tempReviewId}) async {
    Map<String, dynamic> dataMap = {};
    //
    return dataMap;
  }

  Future<void> rejectBooking({required int tempBookingId}) async {
    if (_authController.token == null) {
      throw TokenNotFoundException('Token not found');
    }

    try {
      var response = await http.delete(
        Uri.parse('${NetworkConstants.baseUrl}/api/booking/temp/remove'),
        headers: {
          'Authorization': 'Bearer ${_authController.token!}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(tempBookingId),
      );

      if (response.statusCode == 401) {
        await _authController.logout();
        throw TokenExpiredException('Token expired');
      }

      if (!(response.statusCode >= 200 && response.statusCode < 300)) {
        print(response.body);
        throw NetworkException('Failed to reject booking');
      }
    } on FormatException catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Map<String,dynamic>> addBooking({required Map<String, dynamic> map}) async {

    print(map);

    if (_authController.token == null) {
      throw TokenNotFoundException('Token not found');
    }

    try {
      var response = await http.post(
        Uri.parse('${NetworkConstants.baseUrl}/api/booking/add'),
        headers: {
          'Authorization': 'Bearer ${_authController.token!}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(map),
      );

      if (response.statusCode == 401) {
        await _authController.logout();
        throw TokenExpiredException('Token expired');
      }

      if (!(response.statusCode >= 200 && response.statusCode < 300)) {
        print(response.body);
        throw NetworkException('Failed to add booking');
      }
      Map<String, dynamic> decoded = jsonDecode(response.body);
      return decoded;
    } on FormatException catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> removeReservation({required int reservationId}) async {
    if (_authController.token == null) {
      throw TokenNotFoundException('Token not found');
    }

    try {
      var response = await http.delete(
        Uri.parse('${NetworkConstants.baseUrl}/api/booking/temp/remove'),
        headers: {
          'Authorization': 'Bearer ${_authController.token!}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(reservationId),
      );

      if (response.statusCode == 401) {
        await _authController.logout();
        throw TokenExpiredException('Token expired');
      }

      if (!(response.statusCode >= 200 && response.statusCode < 300)) {
        print(response.body);
        throw NetworkException('Failed to remove booking');
      }
    } on FormatException catch (e) {
      print(e);
      rethrow;
    }
  }
}
