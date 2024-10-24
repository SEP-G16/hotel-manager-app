import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_manager/enum/room_type.dart';
import 'package:hotel_manager/models/reservation.dart';
import 'package:hotel_manager/models/booking.dart';
import 'package:hotel_manager/models/room.dart';

import '../../exception/network_exception.dart';
import '../network/booking_network_controller.dart';

class BookingDataController extends GetxController {
  static final BookingDataController instance = Get.find();

  final BookingNetworkController _bnc = BookingNetworkController.instance;

  RxList<Reservation> _tempBookingList = <Reservation>[].obs;

  List<Reservation> get tempBookingList => _tempBookingList;
  RxList<Reservation> listenableReservationList = <Reservation>[].obs;

  RxList<Booking> _bookingList = <Booking>[].obs;

  List<Booking> get bookingList => _bookingList;
  RxList<Booking> listenableBookingList = <Booking>[].obs;

  BookingDataController._();

  static Future<BookingDataController> create() async {
    final BookingDataController controller = BookingDataController._();
    await controller._initController();
    return controller;
  }

  Future<void> reinitController() async {
    await _initController();
  }

  Future<void> _initController() async {
    List<Reservation> tempBookingList = await _getTempBookings();
    tempBookingList.sort((a, b) => a.createdAt.isBefore(b.createdAt) ? 1 : 0);
    _tempBookingList.assignAll(tempBookingList);
    listenableReservationList.assignAll(tempBookingList);

    List<Booking> acceptedBookingList = await _getAcceptedBookings();
    acceptedBookingList.sort(
      (a, b) {
        if (a.createdAt != null && b.createdAt != null) {
          return a.createdAt!.isBefore(b.createdAt!) ? 1 : 0;
        }
        return 0;
      },
    );
    _bookingList.assignAll(acceptedBookingList);
    listenableBookingList.assignAll(acceptedBookingList);
  }

  Future<List<Reservation>> _getTempBookings() async {
    try {
      List<Map<String, dynamic>> tempBookingsMapList =
          await _bnc.getTempBookings();
      return tempBookingsMapList
          .map((map) => Reservation.fromMap(map))
          .toList();
    } on NetworkException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Booking>> _getAcceptedBookings() async {
    try {
      List<Map<String, dynamic>> acceptedBookingsMapList =
          await _bnc.getAcceptedBookings();
      return acceptedBookingsMapList
          .map((map) => Booking.fromMap(map))
          .toList();
    } on NetworkException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> acceptBooking({required int tempBookingId}) async {
    try {
      //check sort
    } on NetworkException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> rejectBooking({required int tempBookingId}) async {
    try {
      await _bnc.rejectBooking(tempBookingId: tempBookingId);
      tempBookingList
          .removeWhere((tempBooking) => tempBooking.id == tempBookingId);
      listenableReservationList.assignAll(tempBookingList);
    } on NetworkException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getAvailabilityStatus(
      DateTime from, DateTime to, RoomType roomType,
      {int? expectedCount}) async {
    try {
      List<Map<String, dynamic>> availabilityMapList =
          await _bnc.getAvailableRoomCount(from: from, to: to);
      Map<String, dynamic> availabilityMap = availabilityMapList
          .firstWhere((map) => map['type']! == roomType.getRoomTypeAsString());

      int availableCount = (availabilityMap['roomCount']! as int);

      return availableCount != 0 && availableCount >= (expectedCount ?? 0)
          ? 'Available'
          : 'Unavailable';
    } on NetworkException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Room>> getAvailableRoomsList(
      DateTime from, DateTime to, RoomType roomType) async {
    try {
      List<Map<String, dynamic>> availableRoomList = await _bnc
          .getAvailableRoomsList(from: from, to: to, roomType: roomType);
      return availableRoomList.map((map) {
        print(map);
        // Map<String, dynamic> edited = {};
        // edited['id'] = map['roomId']!;
        // edited['roomNo'] = map['roomNo']!;
        // edited['roomType'] = roomType.getRoomTypeAsString();
        map['roomType'] = roomType.getRoomTypeAsString();
        return Room.fromAvailabilityMap(map);
      }).toList();
    } on NetworkException catch (e) {
      rethrow;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> addBookingByReservation(
      {required Reservation reservation, required List<Room> roomList}) async {
    try {
      Booking booking = Booking.fromReservation(reservation, roomList);
      Map<String, dynamic> bookingMap = booking.toMap();
      bookingMap['id'] = null;
      Map<String, dynamic> newBookingMap =
          await _bnc.addBooking(map: bookingMap);

      await _bnc.removeReservation(reservationId: reservation.id);

      _bookingList.add(Booking.fromMap(newBookingMap));
      listenableBookingList.add(Booking.fromMap(newBookingMap));

      _tempBookingList.removeWhere(
          (existingReservation) => existingReservation.id == reservation.id);
      listenableReservationList.removeWhere(
          (existingReservation) => existingReservation.id == reservation.id);
    } on NetworkException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> cancelBooking({required int bookingId}) async {
    await _bnc.cancelBooking(bookingId: bookingId);
    _bookingList.removeWhere((booking) => booking.id == bookingId);
    listenableBookingList.assignAll(_bookingList);
  }

  Future<void> addBookingByBooking({required Booking booking}) async {
    await _bnc.addBooking(map: booking.toMap());
  }
}
