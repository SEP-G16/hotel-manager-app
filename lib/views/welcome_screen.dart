import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_manager/constants/svg_constants.dart';
import 'package:hotel_manager/constants/text_constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SvgPicture.string(SvgConstants.hotelImage),
            Text('Welcome\nHotel Manager!', style: TextConstants.mainTextStyle(), textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}
