import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class SecureStorageController extends GetxController {
  static SecureStorageController instance = Get.find();

  late final FlutterSecureStorage _storage;

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  @override
  void onInit() {
    _storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    super.onInit();
  }

  Future<void> writeSecureData({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> readSecureData({required String key}) async {
    return await _storage.read(key: key);
  }

  Future<void> deleteSecureData({required String key}) async {
    await _storage.delete(key: key);
  }
}