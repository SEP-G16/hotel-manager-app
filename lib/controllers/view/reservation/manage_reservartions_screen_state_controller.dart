import 'package:get/get.dart';
import 'package:hotel_manager/controllers/data/booking_data_controller.dart';
import 'package:hotel_manager/models/reservation.dart';
import 'package:hotel_manager/models/booking.dart';

class BookingTabViewScreenStateController extends GetxController {
  static final BookingTabViewScreenStateController instance = Get.find();

  final BookingDataController _bdc = BookingDataController.instance;


  List<Booking> _bookingList = [];
  RxList<Booking> _displayedBookingList = <Booking>[].obs;
  List<Booking> get displayedBookingList => _displayedBookingList;

  String? searchText;

  void handleSearchTextChange(String value) {
    searchText = value;
    if (value.isEmpty) {
      _displayedBookingList.assignAll(_bookingList);
    } else {
      _displayedBookingList.assignAll(_bookingList.where((element) =>
      element.customerName.toLowerCase().contains(value.toLowerCase()) ||
          element.phoneNo.toLowerCase().contains(value.toLowerCase())));
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _bookingList.assignAll(_bdc.bookingList);
    _displayedBookingList.assignAll(_bookingList);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    ever(_bdc.listenableBookingList, (value) {
      _bookingList.assignAll(value);
      _displayedBookingList.assignAll(value);
    });
  }

  Future<void> reInitController() async {
    await _bdc.reinitController();
  }
}

class TempBookingTabViewScreenStateController extends GetxController {
  static final TempBookingTabViewScreenStateController instance = Get.find();

  final BookingDataController _bdc = BookingDataController.instance;

  List<Reservation> _reservationList = <Reservation>[];
  RxList<Reservation> _displayedReservationList = <Reservation>[].obs;

  List<Reservation> get displayedReservationList => _displayedReservationList;

  String? searchText;

  void handleSearchTextChange(String value) {
    searchText = value;
    if (value.isEmpty) {
      _displayedReservationList.assignAll(_reservationList);
    } else {
      _displayedReservationList.assignAll(_reservationList.where((element) =>
          element.customerName.toLowerCase().contains(value.toLowerCase()) ||
          element.phoneNo.toLowerCase().contains(value.toLowerCase())));
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _reservationList.assignAll(_bdc.tempBookingList);
    _displayedReservationList.assignAll(_reservationList);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    ever(_bdc.listenableReservationList, (value) {
      _reservationList.assignAll(value);
      _displayedReservationList.assignAll(value);
    });
  }

  Future<void> reInitController() async {
    await _bdc.reinitController();
  }
}
