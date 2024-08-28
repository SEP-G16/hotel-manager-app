class Employee {
  final int id;
  final String name;
  final String role;
  final String gender;
  final DateTime dateOfBirth;
  final String address;
  final String phoneNo;
  String? email;

  Employee({
    required this.id,
    required this.name,
    required this.role,
    required this.gender,
    required this.dateOfBirth,
    required this.address,
    required this.phoneNo,
    this.email,
  });
}
