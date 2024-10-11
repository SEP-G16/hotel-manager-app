import 'package:hotel_manager/enum/gender.dart';
import 'package:hotel_manager/extension/datetime_extension.dart';
import 'package:hotel_manager/models/role.dart';

class Employee {
  int id;
  String name;
  String email;
  String phoneNumber;
  String address;
  Gender gender;
  Role role;
  DateTime dateOfBirth;
  DateTime? createdAt;
  DateTime? updatedAt;

  Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.gender,
    required this.role,
    required this.dateOfBirth,
    this.createdAt,
    this.updatedAt,
  });

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
      role: Role.fromMap(map['role']),
      gender: Gender.getGenderFromName(map['gender']!),
      dateOfBirth: DateTime.parse(map['dateOfBirth']),
      createdAt:
      map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt:
      map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'email': email,
    'phoneNumber': phoneNumber,
    'address': address,
    'role': role.toMap(),
    'gender': gender.getGenderAsString(),
    'dateOfBirth': dateOfBirth.toIsoFormattedDateTime(),
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };
}
