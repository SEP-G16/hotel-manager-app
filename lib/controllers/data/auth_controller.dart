import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hotel_manager/controllers/data/secure_storage_controller.dart';
import 'package:hotel_manager/controllers/network/auth_network_controller.dart';
import 'package:hotel_manager/exception/network_exception.dart';
import 'package:hotel_manager/exception/token_expired_exception.dart';
import 'package:hotel_manager/exception/token_not_found_exception.dart';
import 'package:hotel_manager/exception/unauthorized_exception.dart';
import 'package:hotel_manager/views/loading_screen.dart';
import 'package:hotel_manager/views/login_screen.dart';

import '../../enum/role.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  final SecureStorageController _ssc = SecureStorageController.instance;

  final AuthNetworkController _anc = AuthNetworkController.instance;

  late final Rx<String?> _token;

  Rx<Role?> role = null.obs;

  String? get token => _token.value;

  AuthController._();

  static Future<AuthController> create() async {
    final AuthController controller = AuthController._();
    await controller._initController();
    return controller;
  }

  Future<void> _initController() async {
    try {
      await _getTokenFromSecureStorage();
      await _fetchRole();

      Get.offAll(
        () => LoadingScreen(),
        transition: Transition.zoom,
        duration: const Duration(milliseconds: 300),
      );
    } on TokenNotFoundException catch (e) {
      Get.offAll(
        () => const LoginScreen(),
        transition: Transition.zoom,
        duration: const Duration(milliseconds: 300),
      );
    } on TokenExpiredException catch (e) {
      await _ssc.deleteSecureData(key: 'token');
      _token.value = null;
      Get.offAll(
        () => const LoginScreen(),
        transition: Transition.zoom,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  Future<void> _getTokenFromSecureStorage() async {
    _token = Rx<String?>(null);
    String? token = await _ssc.readSecureData(key: 'token');
    if (token == null) {
      throw TokenNotFoundException('Token not found');
    }
    _token.value = token;
  }

  Future<void> _fetchRole() async {
    Map<String, dynamic> data = await _anc.fetchRole(token: _token.value!);
    role = Rx<Role?>(Role.fromString(data['roles'].first.toString()));
  }

  Future<void> login({required String email, required String password}) async {
    try {
      String token = await _anc.login(email: email, password: password);
      await _ssc.writeSecureData(key: 'token', value: token);
      _token.value = token;
      await _fetchRole();
    } on RequestUnauthorizedException catch (e) {
      print(e);
      rethrow;
    } on NetworkException catch (e) {
      print(e);
      rethrow;
    } on FormatException catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> logout() async {
    await _ssc.deleteSecureData(key: 'token');
    _token.value = null;
  }

  bool hasRole(List<Role> list) {
    if (role.value == null) {
      return false;
    }
    return list.contains(role.value!);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    ever(_token, (tokenValue) {
      if (tokenValue == null) {
        Get.offAll(
          () => const LoginScreen(),
          transition: Transition.zoom,
          duration: const Duration(milliseconds: 300),
        );
      } else {
        Get.offAll(
          () => const LoadingScreen(),
          transition: Transition.zoom,
          duration: const Duration(milliseconds: 300),
        );
      }
    });
  }
}
