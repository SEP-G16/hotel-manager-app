import 'package:get/get.dart';
import 'package:hotel_manager/controllers/data/booking_data_controller.dart';
import 'package:hotel_manager/controllers/data/review_data_controller.dart';
import 'package:hotel_manager/enum/review_status.dart';

class DashboardStateController extends GetxController{
  static DashboardStateController instance = Get.find();

  BookingDataController _bookingDataController = BookingDataController.instance;
  ReviewDataController _reviewDataController = ReviewDataController.instance;
  
  RxInt _reservationCount = 0.obs;
  int get reservationCount => _reservationCount.value;
  
  RxInt _bookingCount = 0.obs;
  int get bookingCount => _bookingCount.value;
  
  RxInt _reviewCount = 0.obs;
  int get reviewCount => _reviewCount.value;
  
  RxInt _messageCount = 0.obs;
  int get messageCount => _messageCount.value;
  
  void _initController()
  {

    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    _reservationCount.value = _bookingDataController.tempBookingList.length;
    _bookingCount.value = _bookingDataController.bookingList.where((booking) => booking.checkinDate == today).length;
    _reviewCount.value = _reviewDataController.reviewList.where((review) {
      print(review.toString());
      return review.status == ReviewStatus.Pending;
    }).length;

    //message value would be useful
  }
  
  @override
  void onInit() {
    // TODO: implement onInit
    _initController();
    super.onInit();
  }
}