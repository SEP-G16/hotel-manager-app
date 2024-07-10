import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_manager/components/action_button.dart';
import 'package:hotel_manager/components/named_input_field.dart';
import 'package:hotel_manager/constants/colour_constants.dart';
import 'package:hotel_manager/constants/svg_constants.dart';
import 'package:hotel_manager/constants/text_constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColourConstants.ivory,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: ColourConstants.mainBlue,
                            size: 30,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'My Profile',
                          style: TextConstants.mainTextStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundColor: ColourConstants.mainBlue,
                      child: CircleAvatar(
                        radius: 75,
                        child: SvgPicture.string(
                          SvgConstants.avatarImage,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 10,
                      child: GestureDetector(
                        onTap: (){},
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: ColourConstants.mainBlue,
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),
                NamedInputField(titleText: 'Name', onChanged: (value){}),
                // SizedBox(height: 20.0,),
                NamedInputField(titleText: 'Position', onChanged: (value){}),
                // SizedBox(height: 20.0,),
                NamedInputField(titleText: 'Email', onChanged: (value){}),
                // SizedBox(height: 20.0,),
                NamedInputField(titleText: 'Phone No.', onChanged: (value){}),
                SizedBox(height: 20.0,),
                ActionButton(btnText: 'Change Password', onTap: (){}, width: 220,),
                SizedBox(height: 20.0,),
                ActionButton(btnText: 'Logout', onTap: (){}, width: 220,),
                SizedBox(height: 20.0,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
