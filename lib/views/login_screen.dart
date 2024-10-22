import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_manager/components/action_button.dart';
import 'package:hotel_manager/components/input_field.dart';
import 'package:hotel_manager/constants/colour_constants.dart';
import 'package:hotel_manager/constants/svg_constants.dart';
import 'package:hotel_manager/constants/text_constants.dart';
import 'package:hotel_manager/controllers/data/auth_controller.dart';
import 'package:hotel_manager/views/loading_screen.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? email;
    String? password;

    return Scaffold(
      backgroundColor: ColourConstants.ivory,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SvgPicture.string(
                    SvgConstants.loginScreenImage,
                    height: 300,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Login To Your\nAccount',
                    textAlign: TextAlign.center,
                    style: TextConstants.mainTextStyle(fontSize: 35),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  InputField(
                      labelText: 'Email',
                      onChanged: (value) {
                        email = value;
                      }),
                  SizedBox(
                    height: 20.0,
                  ),
                  InputField(
                      obscureText: true,
                      labelText: 'Password',
                      onChanged: (value) {
                        password = value;
                      }),
                  SizedBox(
                    height: 20.0,
                  ),
                  ActionButton(
                    btnText: 'Login',
                    onTap: () async {
                      if (email == null) {
                        Get.snackbar('Error', 'Please enter your email',
                            snackPosition: SnackPosition.BOTTOM);
                        return;
                      }

                      RegExp emailRegExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
                      if(!emailRegExp.hasMatch(email!))
                      {
                        Get.snackbar('Error', 'Please enter a valid email',
                            snackPosition: SnackPosition.BOTTOM);
                        return;
                      }

                      if (password == null) {
                        Get.snackbar('Error', 'Please enter your password',
                            snackPosition: SnackPosition.BOTTOM);
                        return;
                      }
                      try {
                        await AuthController.instance
                            .login(email: email!, password: password!);
                      } catch (e) {
                        print(e);
                        Get.snackbar('Error', e.toString(),
                            snackPosition: SnackPosition.BOTTOM);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
