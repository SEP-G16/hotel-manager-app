import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hotel_manager/enum/room_type.dart';
import 'package:hotel_manager/models/Reservation.dart';

import '../../../models/booking.dart';

class BookingTabController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  RxInt _selectedIndex = 0.obs;
  RxString _selectedRoomType = 'All'.obs;

  int get selectedIndex => _selectedIndex.value;
  String get selectedRoomType => _selectedRoomType.value;

  final RxList<Reservation> _reservations = <Reservation>[].obs;
  final RxList<Booking> _bookings = <Booking>[].obs;

  List<Reservation> get filteredTemporaryRooms {
    if (selectedRoomType == 'All') {
      return _reservations;
    }
    return _reservations.where((room) => room.roomType.getRoomTypeAsString().toLowerCase() == selectedRoomType.toLowerCase()).toList();
  }

  List<Booking> get filteredConfirmedRooms {
    if (selectedRoomType == 'All') {
      return _bookings;
    }
    return _bookings.where((room) => room.roomType.getRoomTypeAsString().toLowerCase() == selectedRoomType.toLowerCase()).toList();
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);

    // Initialize room data
    // _reservations.addAll([
    //   R(number: 'Room Number : 21', type: 'Standard', checkInDate: DateTime.now(), checkOutDate: DateTime.now().add(Duration(days: 1)), adults: 2, children: 1, roomCount: 1),
    //   Room(number: 'Room Number : 22', type: 'Standard', checkInDate: DateTime.now(), checkOutDate: DateTime.now().add(Duration(days: 1)), adults: 2, children: 0, roomCount: 1),
    //   Room(number: 'Room Number : 23', type: 'Standard', checkInDate: DateTime.now(), checkOutDate: DateTime.now().add(Duration(days: 2)), adults: 1, children: 0, roomCount: 1),
    //   Room(number: 'Room Number : 24', type: 'Deluxe', checkInDate: DateTime.now(), checkOutDate: DateTime.now().add(Duration(days: 3)), adults: 2, children: 2, roomCount: 1),
    //   Room(number: 'Room Number : 25', type: 'Deluxe', checkInDate: DateTime.now(), checkOutDate: DateTime.now().add(Duration(days: 1)), adults: 3, children: 1, roomCount: 2),
    //   Room(number: 'Room Number : 26', type: 'Family', checkInDate: DateTime.now(), checkOutDate: DateTime.now().add(Duration(days: 2)), adults: 2, children: 3, roomCount: 1),
    //   Room(number: 'Room Number : 27', type: 'Family', checkInDate: DateTime.now(), checkOutDate: DateTime.now().add(Duration(days: 1)), adults: 2, children: 2, roomCount: 1),
    // ]);
    //
    // _bookings.addAll([
    //   Room(number: 'Room Number : 10', type: 'Standard', checkInDate: DateTime.now().subtract(Duration(days: 1)), checkOutDate: DateTime.now(), adults: 2, children: 1, roomCount: 1),
    //   Room(number: 'Room Number : 11', type: 'Deluxe', checkInDate: DateTime.now().subtract(Duration(days: 1)), checkOutDate: DateTime.now(), adults: 1, children: 0, roomCount: 1),
    //   Room(number: 'Room Number : 14', type: 'Family', checkInDate: DateTime.now().subtract(Duration(days: 2)), checkOutDate: DateTime.now().subtract(Duration(days: 1)), adults: 2, children: 2, roomCount: 1),
    // ]);

    tabController.addListener(() {
      _selectedIndex.value = tabController.index;
      print(selectedIndex);
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void updateSelectedRoomType(String roomType) {
    _selectedRoomType.value = roomType;
    update(); // Notify listeners to rebuild
  }

  // Method to move room from temporary to confirmed
  void moveReservationToConfirmed(Reservation reservation) {
    _reservations.remove(reservation);
    // _bookings.add(room);
    update(); // Notify listeners to rebuild
  }

  void rejectReservation(Reservation reservation){
    _reservations.remove(reservation);
    update();
  }

  void cancelBooking(Booking booking){
    _bookings.remove(booking);
    update();
  }
  // Inside BookingTabController

  void addBooking(Booking booking) {
    _bookings.add(booking);
    update(); // Notify listeners to rebuild
  }

}

// class Room {
//   final String number;
//   final String type;
//   final DateTime checkInDate;
//   final DateTime checkOutDate;
//   final int adults;
//   final int children;
//   final int roomCount;
//
//   Room({
//     required this.number,
//     required this.type,
//     required this.checkInDate,
//     required this.checkOutDate,
//     required this.adults,
//     required this.children,
//     required this.roomCount,
//   });
// }
