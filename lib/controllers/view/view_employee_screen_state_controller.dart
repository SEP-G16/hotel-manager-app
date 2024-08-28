import 'package:get/get.dart';
import 'package:hotel_manager/models/employee.dart';
import 'package:hotel_manager/models/form_valid_response.dart';

class ViewEmployeeScreenStateController extends GetxController {

  final RegExp _nameRegExp = RegExp(r"^[a-zA-Z\s'-]+$");
  final RegExp _phoneRegExp = RegExp(r"^\+?(\d[\d-. ]+)?(\([\d-. ]+\))?[\d-. ]+\d$");
  final RegExp _emailRegExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

  RxBool _editMode = false.obs;
  bool get editMode => _editMode.value;
  set editMode(bool value) => _editMode.value = value;

  Rx<String?> _name = ''.obs;
  String? get name => _name.value;
  set name(String? value) => _name.value = value;

  Rx<String?> _role = ''.obs;
  String? get role => _role.value;
  set role(String? value) => _role.value = value;

  Rx<String?> _gender = ''.obs;
  String? get gender => _gender.value;
  set gender(String? value) => _gender.value = value;

  Rx<DateTime?> _dateOfBirth = DateTime.now().obs;
  DateTime? get dateOfBirth => _dateOfBirth.value;
  set dateOfBirth(DateTime? value) => _dateOfBirth.value = value;

  Rx<String?> _address = ''.obs;
  String? get address => _address.value;
  set address(String? value) => _address.value = value;

  Rx<String?> _phoneNo = ''.obs;
  String? get phoneNo => _phoneNo.value;
  set phoneNo(String? value) => _phoneNo.value = value;

  Rx<String?> _email = ''.obs;
  String? get email => _email.value;
  set email(String? value) => _email.value = value;

  ViewEmployeeScreenStateController({required Employee employee})
  {
    _name.value = employee.name;
    _role.value = employee.role;
    _gender.value = employee.gender;
    _dateOfBirth.value = employee.dateOfBirth;
    _address.value = employee.address;
    _phoneNo.value = employee.phoneNo;
    _email.value = employee.email;
  }

  FormValidResponse validateForm() {
    final validationRules = [
      {'condition': _name.value == null || _name.value == '', 'message': 'Name cannot be empty!'},
      {'condition': !_nameRegExp.hasMatch(_name.value!), 'message': 'Name is not valid'},
      {'condition': _role.value == 'Select', 'message': 'You have to select a role!'},
      {'condition': _gender.value == 'Select', 'message': 'You have to select a gender!'},
      {'condition': _dateOfBirth.value == null, 'message': 'Date of Birth cannot be empty!'},
      {'condition': _address.value == null || _address.value == '', 'message': 'Address cannot be empty!'},
      {'condition': _phoneNo.value == null || _phoneNo.value == '', 'message': 'Phone Number cannot be empty!'},
      {'condition': !_phoneRegExp.hasMatch(_phoneNo.value!), 'message': 'Phone Number is not valid'},
      {'condition': _email.value != null && _email.value != '' && !_emailRegExp.hasMatch(_email.value!), 'message': 'Email is not valid'},
    ];

    for (final rule in validationRules) {
      if (rule['condition'] as bool) {
        return FormValidResponse(formValid: false, message: rule['message'] as String);
      }
    }

    return FormValidResponse(formValid: true);
  }
}
