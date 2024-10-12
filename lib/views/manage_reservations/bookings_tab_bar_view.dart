import 'package:flutter/material.dart';
import 'package:hotel_manager/components/action_button.dart';
import 'package:hotel_manager/controllers/view/reservation/manage_reservartions_screen_state_controller.dart';
import 'package:hotel_manager/views/manage_reservations/add_booking_screen.dart';
import 'package:hotel_manager/views/manage_reservations/view_booking_screen.dart';

import '../../components/booking_tile.dart';
import '../../constants/colour_constants.dart';
import '../../constants/text_constants.dart';
import '../../enum/room_type.dart';
import '../../models/booking.dart';
import '../../models/room.dart';
import 'package:get/get.dart';

class BookingsTabBarView extends StatelessWidget {
  const BookingsTabBarView({super.key, required this.bookings});

  final List<Booking> bookings;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              // IconButton(
              //     onPressed: () {
              //       Scaffold.of(context).openDrawer();
              //     },
              //     icon: Icon(
              //       Icons.filter_list_rounded,
              //       size: 30,
              //     )),
              // SizedBox(
              //   width: 10,
              // ),
              Expanded(
                child: SearchAnchor(builder: (context, controller) {
                  return SearchBar(
                    onChanged: (value) {
                      BookingTabViewScreenStateController.instance
                          .handleSearchTextChange(value);
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
            child: Obx(
              () => Column(
                children:
                    BookingTabViewScreenStateController.instance.displayedBookingList
                        .map<BookingTile>((booking) => BookingTile(
                            booking: booking,
                            onArrowTap: () {
                              Get.to(() => ViewBookingScreen(booking: booking));
                            }))
                        .toList(),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: ActionButton(
            btnText: 'Add Booking',
            onTap: () {
              Get.to(() => AddBookingScreen());
            },
            width: 180,
          ),
        ),
      ],
    );
  }
}
