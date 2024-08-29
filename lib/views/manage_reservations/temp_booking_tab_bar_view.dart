import 'package:flutter/material.dart';
import 'package:hotel_manager/components/reservation_tile.dart';
import 'package:hotel_manager/constants/colour_constants.dart';
import 'package:hotel_manager/constants/text_constants.dart';
import 'package:hotel_manager/views/manage_reservations/view_reservation_screen.dart';
import '../../models/reservation.dart';
import 'package:get/get.dart';

class TempBookingTabBarView extends StatelessWidget {
  const TempBookingTabBarView({required this.reservations});

  final List<Reservation> reservations;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(
                    Icons.filter_list_rounded,
                    size: 30,
                  )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: SearchAnchor(
                    builder: (context, controller) {
                  return SearchBar(
                    onChanged: (value) {
                    },
                    leading: IconButton(
                      icon: Icon(
                        Icons.search_rounded,
                        color: ColourConstants.mainBlue,
                      ),
                      onPressed: () {},
                    ),
                    hintText: 'Enter Name or Phone No.',
                    hintStyle: WidgetStateTextStyle.resolveWith(
                      (_) => TextConstants.subTextStyle(
                        fontSize: 16,
                        color: ColourConstants.chineseBlack.withOpacity(0.4),
                      ),
                    ),
                    textStyle: WidgetStateTextStyle.resolveWith(
                      (_) => TextConstants.subTextStyle(
                        fontSize: 16,
                        color: ColourConstants.chineseBlack,
                      ),
                    ),
                  );
                }, suggestionsBuilder: (context, controller) {
                  return [];
                }),
              )
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: reservations
                  .map<ReservationTile>((reservation) => ReservationTile(
                      reservation: reservation,
                      onArrowTap: () {
                        Get.to(() =>
                            ViewReservationScreen(reservation: reservation));
                      }))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
