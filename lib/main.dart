import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hotel_manager/constants/colour_constants.dart';
import 'package:get/get.dart';
import 'package:hotel_manager/views/welcome_screen.dart';

import 'controllers/data/auth_controller.dart';
import 'controllers/data/secure_storage_controller.dart';
import 'controllers/network/auth_network_controller.dart';


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}


// Initial comment
void main() async {
  HttpOverrides.global = MyHttpOverrides();
  Get.put(SecureStorageController());
  Get.put(AuthNetworkController());

  runApp(const HotelManager());

  await Get.putAsync(() => AuthController.create());
}

class HotelManager extends StatelessWidget {
  const HotelManager({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.light(primary: ColourConstants.mainBlue),
        useMaterial3: true,
      ),
      home: WelcomeScreen(),
    );
  }
}
