import 'dart:convert';

import 'package:get/get.dart';
import 'package:hotel_manager/constants/network_constants.dart';
import 'package:hotel_manager/controllers/data/auth_controller.dart';
import 'package:hotel_manager/exception/network_exception.dart';
import 'package:hotel_manager/exception/token_not_found_exception.dart';
import 'package:http/http.dart' as http;

class StaffNetworkController extends GetxController{
  static StaffNetworkController instance = Get.find();

  final AuthController _authController = AuthController.instance;

  Future<List<Map<String, dynamic>>> getAllRoles() async {

    if(_authController.token == null){
      _authController.logout();
      throw TokenNotFoundException('Token not found');
    }

    try {
      var response = await http.get(
        Uri.parse('${NetworkConstants.baseUrl}/api/staff/role/all'),
        headers: {
          'Authorization': 'Bearer ${_authController.token!}',
          'Content-Type': 'application/json',
        },
      );

      if(response.statusCode != 200){
        throw NetworkException('Failed to fetch roles');
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

  Future<List<Map<String, dynamic>>> getAllEmployees() async {

    if(_authController.token == null){
      _authController.logout();
      throw TokenNotFoundException('Token not found');
    }

    try {
      var response = await http.get(
        Uri.parse('${NetworkConstants.baseUrl}/api/staff/all'),
        headers: {
          'Authorization': 'Bearer ${_authController.token!}',
          'Content-Type': 'application/json',
        },
      );

      if(response.statusCode != 200){
        throw NetworkException('Failed to fetch employees');
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

  Future<Map<String, dynamic>> addEmployee(Map<String, dynamic> newEmployeeMap) async {

    if(_authController.token == null){
      _authController.logout();
      throw TokenNotFoundException('Token not found');
    }

    try {
      var response = await http.post(
        Uri.parse('${NetworkConstants.baseUrl}/api/staff/add'),
        headers: {
          'Authorization': 'Bearer ${_authController.token!}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(newEmployeeMap),
      );

      if(response.statusCode != 201){
        print(response.body);
        throw NetworkException('Failed to add employee');
      }

      return jsonDecode(response.body);

    } on FormatException catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> updateEmployee(Map<String, dynamic> updatedEmployeeMap) async {

    if(_authController.token == null){
      _authController.logout();
      throw TokenNotFoundException('Token not found');
    }

    try {
      var response = await http.put(
        Uri.parse('${NetworkConstants.baseUrl}/api/staff/update'),
        headers: {
          'Authorization': 'Bearer ${_authController.token!}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(updatedEmployeeMap),
      );

      if(response.statusCode != 200){
        throw NetworkException('Failed to add employee');
      }

      return jsonDecode(response.body);

    } on FormatException catch (e) {
      rethrow;
    }
  }

  Future<void> deleteEmployee({required int employeeId}) async {

    if(_authController.token == null){
      _authController.logout();
      throw TokenNotFoundException('Token not found');
    }

    try {
      var response = await http.delete(
        Uri.parse('${NetworkConstants.baseUrl}/api/staff/remove/$employeeId'),
        headers: {
          'Authorization': 'Bearer ${_authController.token!}',
          'Content-Type': 'application/json',
        },
      );

      if(response.statusCode != 200){
        print(response.body);
        throw NetworkException('Failed to remove employee');
      }
    } on FormatException catch (e) {
      rethrow;
    }
  }
}