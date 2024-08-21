import 'package:get/get.dart';

class AddReservationViewStateController extends GetxController {

  static AddReservationViewStateController instance = Get.find();

  Rx _selectedValue = (-1).obs;
  dynamic get selectedValue => _selectedValue.value;
  set selectedValue(value) => _selectedValue.value = value;

  RxString _selectedCategory = 'Select'.obs;
  String get selectedCategory => _selectedCategory.value;
  set selectedCategory(String value) => _selectedCategory.value = value;

  Rx<DateTime> _selectedDate = DateTime.now().obs;
  DateTime get selectedDate => _selectedDate.value;
  set selectedDate(value) => _selectedDate.value = value;
}


