import 'dart:convert';

import 'package:get/get.dart';

import '../../constants/network_constants.dart';
import '../../exception/network_exception.dart';
import '../../exception/token_not_found_exception.dart';
import '../data/auth_controller.dart';
import 'package:http/http.dart' as http;

class CustomerMessageNetworkController extends GetxController{

  static CustomerMessageNetworkController instance = Get.find();

  final AuthController _authController = AuthController.instance;

  Future<List<Map<String, dynamic>>> getAllMessages() async {
      
      if(_authController.token == null){
        _authController.logout();
        throw TokenNotFoundException('Token not found');
      }
  
      try {
        var response = await http.get(
          Uri.parse('${NetworkConstants.baseUrl}/api/contact-us/support-ticket/all'),
          headers: {
            'Authorization': 'Bearer ${_authController.token!}',
            'Content-Type': 'application/json',
          },
        );
  
        if(response.statusCode != 200){
          throw NetworkException('Failed to fetch messages');
        }
  
        List<dynamic> decoded = jsonDecode(response.body);
        return decoded.map<Map<String, dynamic>>((element) {
          Map<String, dynamic> map = element as Map<String, dynamic>;
          return map;
        }).toList();
      } on FormatException catch (e) {
        rethrow;
      }
  }

  Future<void> sendResponse(String message, int ticketId) async {
    if(_authController.token == null){
      _authController.logout();
      throw TokenNotFoundException('Token not found');
    }

    try {
      var response = await http.post(
        Uri.parse('${NetworkConstants.baseUrl}/api/contact-us/ticket-response/add'),
        headers: {
          'Authorization': 'Bearer ${_authController.token!}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'response': message,
          'supportTicket': {
            'id': ticketId,
          }
        }),
      );

      if(response.statusCode != 201){
        throw NetworkException('Failed to send response');
      }
    } on FormatException catch (e) {
      rethrow;
    }
  }

}