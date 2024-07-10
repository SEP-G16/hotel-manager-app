import 'package:get/get.dart';

class AddEmployeeViewStateController extends GetxController {

  static AddEmployeeViewStateController instance = Get.find();

  Rx _selectedValue = (-1).obs;
  dynamic get selectedValue => _selectedValue.value;
  set selectedValue(value) => _selectedValue.value = value;

  RxString _selectedGender = 'Select'.obs;
  String get selectedGender => _selectedGender.value;
  set selectedGender(String value) => _selectedGender.value = value;

  Rx<DateTime> _selectedDate = DateTime.now().obs;
  DateTime get selectedDate => _selectedDate.value;
  set selectedDate(value) => _selectedDate.value = value;
}


