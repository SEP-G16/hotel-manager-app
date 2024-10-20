import 'package:get/get.dart';

class DrawerStateController extends GetxController {

  static DrawerStateController instance = Get.find();

  static const int DASHBAORD_INDEX = 0;
  static const int BOOKINGS_INDEX = 1;
  static const int REVIEWS_INDEX = 2;
  static const int MESSAGES_INDEX = 3;
  static const int STAFF_INDEX = 4;

  RxInt _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;
  set selectedIndex(int value) => _selectedIndex.value = value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _selectedIndex.value = DASHBAORD_INDEX;
  }
}