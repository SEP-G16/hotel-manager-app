import 'package:get/get.dart';

class DrawerStateController extends GetxController {

  static DrawerStateController instance = Get.find();

  RxInt _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;
  set selectedIndex(int value) => _selectedIndex.value = value;
}