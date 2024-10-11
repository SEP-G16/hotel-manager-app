import 'dart:ffi';

import 'package:get/get.dart';

import '../../models/form_valid_response.dart';

class AddEmployeeViewStateController extends GetxController {

  static AddEmployeeViewStateController instance = Get.find();

  final RegExp _nameRegExp = RegExp(r"^[a-zA-Z\s'-]+$");
  final RegExp _phoneRegExp = RegExp(r"^\+?(\d[\d-. ]+)?(\([\d-. ]+\))?[\d-. ]+\d$");
  final RegExp _emailRegExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

  RxString _selectedRole = 'Select'.obs;
  String get selectedRole => _selectedRole.value;
  set selectedRole(value) => _selectedRole.value = value;

  RxString _selectedGender = 'Select'.obs;
  String get selectedGender => _selectedGender.value;
  set selectedGender(String value) => _selectedGender.value = value;

  Rx<DateTime> _selectedDate = DateTime.now().obs;
  DateTime get selectedDate => _selectedDate.value;
  set selectedDate(value) => _selectedDate = value;

  String? _name = '';
  String? get name => _name;
  set name(value) => _name = value;

  String? _address = '';
  String? get address => _address;
  set address(value) => _address = value;

  String? _phoneNo = '';
  String? get phoneNo => _phoneNo;
  set phoneNo(value) => _phoneNo = value;

  String? _email = '';
  String? get email => _email;
  set email(value) => _email = value;

  FormValidResponse validateForm() {
    final validationRules = [
      {'condition': _name == null || _name == '', 'message': 'Name cannot be empty!'},
      {'condition': !_nameRegExp.hasMatch(_name!), 'message': 'Name is not valid'},
      {'condition': _selectedRole.value == 'Select', 'message': 'You have to select a role!'},
      {'condition': _selectedGender == 'Select', 'message': 'You have to select a gender!'},
      {'condition': _selectedDate.value == null, 'message': 'Date of Birth cannot be empty!'},
      {'condition': _address == null || _address == '', 'message': 'Address cannot be empty!'},
      {'condition': _phoneNo == null || _phoneNo == '', 'message': 'Phone Number cannot be empty!'},
      {'condition': !_phoneRegExp.hasMatch(_phoneNo!), 'message': 'Phone Number is not valid'},
      {'condition': _email != null && _email != '' && !_emailRegExp.hasMatch(_email!), 'message': 'Email is not valid'},
    ];

    for (final rule in validationRules) {
      if (rule['condition'] as bool) {
        return FormValidResponse(formValid: false, message: rule['message'] as String);
      }
    }
    return FormValidResponse(formValid: true);
  }
}


