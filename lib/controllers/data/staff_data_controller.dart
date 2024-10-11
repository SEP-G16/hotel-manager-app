import 'package:get/get.dart';
import 'package:hotel_manager/controllers/network/staff_network_controller.dart';
import 'package:hotel_manager/models/employee.dart';

import '../../models/role.dart';

class StaffDataController extends GetxController {

  static StaffDataController get instance => Get.find();

  final StaffNetworkController _snc = StaffNetworkController.instance;

  List<Role> _roles = [];
  List<Role> get roles => _roles;
  RxList<Role> listenableRoleList = <Role>[].obs;

  List<Employee> _employees = [];
  List<Employee> get employees => _employees;
  RxList<Employee> listenableEmployeeList = <Employee>[].obs;

  StaffDataController._();

  static Future<StaffDataController> create() async {
    final StaffDataController controller = StaffDataController._();
    await controller._initController();
    return controller;
  }

  Future<void> reInitController(){
    return _initController();
  }

  Future<void> _initController() async {
    await _fetchRoles();
    await _fetchEmployees();
  }

  Future<void> _fetchRoles() async {
    _roles = (await _snc.getAllRoles()).map<Role>((roleMap) => Role.fromMap(roleMap)).toList();
    listenableRoleList.assignAll(_roles);
  }

  Future<void> _fetchEmployees() async {
    _employees = (await _snc.getAllEmployees()).map((employee) => Employee.fromMap(employee)).toList();
    listenableEmployeeList.assignAll(_employees);
  }

  Future<void> addEmployee(Employee employee) async {
    Map<String, dynamic> employeeMap = employee.toMap();
    employeeMap['id'] = null;
    Map<String, dynamic> newEmployee = await _snc.addEmployee(employeeMap); //Setting to null to avoid database id issues
    _employees.add(Employee.fromMap(newEmployee));
    listenableEmployeeList.assignAll(_employees);
  }

  Future<void> updateEmployee(Employee employee) async {
    Map<String, dynamic> updatedEmployee = await _snc.updateEmployee(employee.toMap());
    _employees[_employees.indexWhere((element) => element.id == updatedEmployee['id'])] = Employee.fromMap(updatedEmployee);
    listenableEmployeeList.assignAll(_employees);
  }

  Future<void> deleteEmployee(int id) async {
    await _snc.deleteEmployee(employeeId :id);
    _employees.removeWhere((element) => element.id == id);
    listenableEmployeeList.assignAll(_employees);
  }
}