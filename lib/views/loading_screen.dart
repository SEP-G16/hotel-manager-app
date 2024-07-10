import 'package:flutter/material.dart';
import 'package:hotel_manager/constants/colour_constants.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
}
