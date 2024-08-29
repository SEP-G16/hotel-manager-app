import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_manager/components/action_button.dart';
import 'package:hotel_manager/components/input_field.dart';
import 'package:hotel_manager/constants/colour_constants.dart';
import 'package:hotel_manager/constants/svg_constants.dart';
import 'package:hotel_manager/constants/text_constants.dart';
import 'package:hotel_manager/views/loading_screen.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    SvgConstants.hotelImage,
                    height: 300,
                  ),
                  SizedBox(height: 20.0,),
                  Text(
                    'Login To Your\nAccount',
                    textAlign: TextAlign.center,
                    style: TextConstants.mainTextStyle(fontSize: 35),
                  ),
                  SizedBox(height: 20.0,),
                  InputField(labelText: 'Email', onChanged: (value){}),
                  SizedBox(height: 20.0,),
                  InputField(labelText: 'Password', onChanged: (value){}),
                  SizedBox(height: 20.0,),
                  ActionButton(btnText: 'Login', onTap: (){
                    //TODO:Edit
                    Get.to(() => LoadingScreen());
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
