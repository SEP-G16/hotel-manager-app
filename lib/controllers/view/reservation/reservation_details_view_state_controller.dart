import 'package:get/get.dart';

class ReservationDetailsViewStateController extends GetxController {

  static ReservationDetailsViewStateController get instance => Get.find();

  // Type-specific Rx variables
  RxInt _selectedValue = (-1).obs;
  int get selectedValue => _selectedValue.value;
  set selectedValue(int value) => _selectedValue.value = value;

  RxInt _selectedAdults = 0.obs;
  int get selectedAdults => _selectedAdults.value;
  set selectedAdults(int value) => _selectedAdults.value = value;

  RxInt _selectedChildren = 0.obs;
  int get selectedChildren => _selectedChildren.value;
  set selectedChildren(int value) => _selectedChildren.value = value;

  RxString _selectedCategory = 'Select'.obs;
  String get selectedCategory => _selectedCategory.value;
  set selectedCategory(String value) => _selectedCategory.value = value;

  Rx<DateTime> _selectedDate = DateTime.now().obs;
  DateTime get selectedDate => _selectedDate.value;
  set selectedDate(DateTime value) => _selectedDate.value = value;
}
