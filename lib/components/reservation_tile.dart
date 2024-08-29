import 'package:flutter/material.dart';
import 'package:hotel_manager/enum/room_type.dart';
import 'package:intl/intl.dart';

import '../constants/colour_constants.dart';
import '../constants/text_constants.dart';
import '../models/reservation.dart';
import 'action_button.dart';

class ReservationTile extends StatelessWidget {
  const ReservationTile(
      {required this.reservation, required this.onArrowTap});

  final Reservation reservation;
  final void Function() onArrowTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: ColourConstants.orchidAccent,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        reservation.customerName,
                        overflow: TextOverflow.ellipsis,
                        style: TextConstants.subTextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Phone No. : ${reservation.phoneNo}',
                        overflow: TextOverflow.ellipsis,
                        style: TextConstants.subTextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Room Type : ${reservation.roomType.getRoomTypeAsString()}',
                        overflow: TextOverflow.ellipsis,
                        style: TextConstants.subTextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Room Count : ${reservation.roomCount}',
                        overflow: TextOverflow.ellipsis,
                        style: TextConstants.subTextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Check In Date : ${DateFormat('yyyy/MM/dd').format(reservation.checkinDate)}',
                        overflow: TextOverflow.ellipsis,
                        style: TextConstants.subTextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Checkout Date : ${DateFormat('yyyy/MM/dd').format(reservation.checkoutDate)}',
                        overflow: TextOverflow.ellipsis,
                        style: TextConstants.subTextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Expanded(child: Column(
          //   children: [
          //     ActionButton(btnText: 'View', onTap: onViewBtnTap, height: 50, width: 100,),
          //   ],
          // ),),
          IconButton(
            onPressed: onArrowTap,
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              color: ColourConstants.mainBlue,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}
