import 'package:flutter/material.dart';
import 'package:hotel_manager/constants/colour_constants.dart';
import 'package:hotel_manager/constants/text_constants.dart';
import 'package:hotel_manager/controller_initalizer.dart';
import 'package:hotel_manager/controllers/data/auth_controller.dart';
import 'package:hotel_manager/enum/role.dart';
import 'package:hotel_manager/views/dashboard_screen.dart';

import 'login_screen.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  Future<String> load() async {
    if (ControllerInitializer.initialised) {
      return '';
    }
    await ControllerInitializer.initController();
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: load(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (AuthController.instance
              .hasRole([Role.ROLE_ADMIN, Role.ROLE_HOTEL_MANAGER])) {
            return DashboardScreen();
          } else {
            Future<String> wait() async {
              await Future.delayed(const Duration(seconds: 5));
              return '';
            }

            return FutureBuilder(
              future: wait(),
              builder: (builder, snapshot) {
                if (snapshot.hasData) {
                  AuthController.instance.logout();
                  return LoginScreen();
                } else {
                  return Scaffold(
                    body: SafeArea(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.center,
                        child: Text(
                          'You are unauthorized to access this app!\nYou\'ll be redirected to the Login Page',
                          style: TextConstants.mainTextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                }
              },
            );
          }
        } else if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: ColourConstants.ivory,
            body: SafeArea(
              child: Center(
                child: Text(
                  'An Unexpected Error Occurred!',
                  style: TextConstants.subTextStyle(color: Colors.red),
                ),
              ),
            ),
          );
        } else {
          return const Scaffold(
            backgroundColor: ColourConstants.ivory,
            body: SafeArea(
              child: Center(
                child: CircularProgressIndicator(
                  color: ColourConstants.mainBlue,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
