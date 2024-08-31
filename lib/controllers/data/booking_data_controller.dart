import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_manager/models/reservation.dart';
import 'package:hotel_manager/models/booking.dart';

import '../../exception/network_exception.dart';
import '../network/booking_network_controller.dart';

class BookingDataController extends GetxController{
  static final BookingDataController instance = Get.find();

  final BookingNetworkController _bnc = BookingNetworkController.instance;

  RxList<Reservation> _tempBookingList = <Reservation>[].obs;
  List<Reservation> get tempBookingList => _tempBookingList;

  RxList<Booking> _bookingList = <Booking>[].obs;
  List<Booking> get bookingList => _bookingList;

  BookingDataController._();

  static Future<BookingDataController> create() async {
    final BookingDataController controller = BookingDataController._();
    controller._initController();
    return controller;
  }

  Future<void> reinitController() async
  {
    await _initController();
  }

  Future<void> _initController() async {
    _tempBookingList.value = await _getTempBookings();
    _bookingList.value = await _getAcceptedBookings();
  }

  Future<List<Reservation>> _getTempBookings() async {
    try {
      List<Map<String, dynamic>> tempBookingsMapList =
      await _bnc.getTempBookings();
      return tempBookingsMapList.map((map) => Reservation.fromMap(map)).toList();
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
      return acceptedBookingsMapList.map((map) => Booking.fromMap(map)).toList();
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

    } on NetworkException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}