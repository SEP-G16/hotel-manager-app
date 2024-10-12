import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_manager/models/employee.dart';

import '../constants/colour_constants.dart';
import '../constants/svg_constants.dart';
import '../constants/text_constants.dart';

class StaffTile extends StatelessWidget {
  StaffTile({
    required this.employee,
    this.onInfoPressed,
    this.onFirePressed,
  });

  final Employee employee;
  void Function()? onInfoPressed;
  void Function()? onFirePressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: ColourConstants.orchidAccent,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employee.name,
                  style: TextConstants.subTextStyle(fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  employee.role.name,
                  style: TextConstants.subTextStyle(fontSize: 18),
                ),
                Text(
                  employee.phoneNumber,
                  style: TextConstants.subTextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: onInfoPressed,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 2.5),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                            color: ColourConstants.richBlack, width: 2)),
                    padding: EdgeInsets.all(5.0),
                    height: 40,
                    width: 80,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Icon(
                            Icons.info,
                            color: ColourConstants.richBlack,
                          ),
                        ),
                        Text(
                          'Info',
                          style: TextConstants.subTextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onFirePressed,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 2.5),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                            color: ColourConstants.red1, width: 2)),
                    padding: EdgeInsets.all(5.0),
                    height: 40,
                    width: 80,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Icon(
                            Icons.close,
                            color: ColourConstants.red1,
                          ),
                        ),
                        Text(
                          'Fire',
                          style: TextConstants.subTextStyle(
                            fontSize: 18,
                            color: ColourConstants.red1,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
