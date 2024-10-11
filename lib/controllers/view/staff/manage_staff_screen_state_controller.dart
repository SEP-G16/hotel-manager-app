import 'package:get/get.dart';
import 'package:hotel_manager/controllers/data/staff_data_controller.dart';
import 'package:hotel_manager/models/employee.dart';

class ManageStaffScreenStateController extends GetxController{

  static final ManageStaffScreenStateController instance = Get.find();

  final StaffDataController _sdc = StaffDataController.instance;

  List<Employee> _employeeList = <Employee>[];
  RxList<Employee> _displayedEmployeeList = <Employee>[].obs;
  List<Employee> get displayedEmployeeList => _displayedEmployeeList;

  String? searchText;

  void handleSearchTextChange(String value){
    searchText = value;
    if(value.isEmpty){
      _displayedEmployeeList.assignAll(_employeeList);
    }else{
      _displayedEmployeeList.assignAll(_employeeList.where((element) => element.name.toLowerCase().contains(value.toLowerCase())));
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _employeeList.assignAll(_sdc.employees);
    _displayedEmployeeList.assignAll(_employeeList);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    ever(_sdc.listenableEmployeeList, (value) {
      _employeeList.assignAll(value);
      _displayedEmployeeList.assignAll(_employeeList);
    });
  }

  Future<void> fireEmployee(int id) async {
    return await _sdc.deleteEmployee(id);
  }
}