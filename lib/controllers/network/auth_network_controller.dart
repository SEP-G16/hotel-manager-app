import 'dart:convert';

import 'package:get/get.dart';
import 'package:hotel_manager/exception/network_exception.dart';
import 'package:hotel_manager/exception/token_expired_exception.dart';
import 'package:hotel_manager/exception/unauthorized_exception.dart';
import 'package:http/http.dart' as http;

import '../../constants/network_constants.dart';

class AuthNetworkController extends GetxController{
  static AuthNetworkController instance = Get.find();

  Future<Map<String, dynamic>> fetchRole({required String token}) async {
    var response = await http.get(
      Uri.parse('${NetworkConstants.baseUrl}/api/auth/profile'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if(response.statusCode == 401){
      throw TokenExpiredException('Token expired');
    }

    return jsonDecode(response.body);
  }

  Future<String> login({required String email, required String password}) async {

    String body = jsonEncode({
      'username': email,
      'password': password,
    });

    var response = await http.post(
      Uri.parse('${NetworkConstants.baseUrl}/api/auth/login'),
      body: body,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if(response.statusCode == 401){
      throw RequestUnauthorizedException('Failed to login with credentials');
    }

    if(response.statusCode != 200){
      throw NetworkException('Failed to login');
    }

    Map<String, dynamic> decoded = jsonDecode(response.body);

    return decoded['token'];
  }
}