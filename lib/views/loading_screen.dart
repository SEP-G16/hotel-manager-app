import 'package:flutter/material.dart';
import 'package:hotel_manager/constants/colour_constants.dart';
import 'package:hotel_manager/constants/text_constants.dart';
import 'package:hotel_manager/views/dashboard_screen.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  Future<String> load() async
  {
    await Future.delayed(Duration(seconds: 1));
    return '';
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: load(), builder: (context, snapshot){
      if(snapshot.hasData)
        {
          return DashboardScreen();
        }
      else if(snapshot.hasError)
        {
          return Scaffold(
            backgroundColor: ColourConstants.ivory,
            body: SafeArea(
              child: Center(
                child: Text('An Unexpected Error Occurred!', style: TextConstants.subTextStyle(color: Colors.red),),
              ),
            ),
          );
        }
      else{

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
    },);
  }
}
