import 'package:get/get.dart';
import 'package:hotel_manager/controllers/data/booking_data_controller.dart';
import 'package:hotel_manager/models/reservation.dart';
import 'package:hotel_manager/models/booking.dart';

class ManageReservationsScreenStateController extends GetxController{
  static final ManageReservationsScreenStateController instance = Get.find();

  final BookingDataController _bdc = BookingDataController.instance;

  RxList<Reservation> _reservationList = <Reservation>[].obs;
  List<Reservation> get reservationList => _reservationList;

  RxList<Booking> _bookingList = <Booking>[].obs;
  List<Booking> get bookingList => _bookingList;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _reservationList.assignAll(_bdc.tempBookingList);
    _bookingList.assignAll(_bdc.bookingList);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    ever(_bdc.listenableReservationList, (value) {
      _reservationList.assignAll(value);
    });

    ever(_bdc.listenableBookingList, (value) {
      _bookingList.assignAll(value);
    });
  }
}