import '../enum/room_type.dart';

class Reservation {
  final int id;
  final DateTime createdAt;
  final String customerName;
  final String phoneNo;
  final String email;
  final int adultCount;
  final int childrenCount;


  final RoomType roomType;
  final int roomCount;
  final DateTime checkinDate;
  final DateTime checkoutDate;

  // final double totalAmount;

  Reservation({
    required this.id,
    required this.createdAt,
    required this.customerName,
    required this.phoneNo,
    required this.roomType,
    required this.roomCount,
    required this.checkinDate,
    required this.checkoutDate,
    required this.adultCount,
    required this.childrenCount,
    required this.email,
    // required this.totalAmount,
  });

  factory Reservation.fromMap(Map<String, dynamic> map) {
    return Reservation(
      id: map['id'],
      createdAt: DateTime.now(),
      // DateTime.parse(map['createdAt']),
      customerName: map['customerName'],
      phoneNo: map['phoneNo'] ?? '0776990588',
      email: map['email'],
      adultCount: map['adultCount'],
      childrenCount: map['childrenCount'],
      roomType: RoomType.values.where((value) {
        String lowercaseType = value.toString().split('.').last.toLowerCase();
        String mapData = map['roomType']!['type'].toString().toLowerCase();
        return lowercaseType == mapData;
      }).toList().first,  // Assuming roomType is an enum
      roomCount: map['roomCount'],
      checkinDate: DateTime.parse(map['checkinDate']),
      checkoutDate: DateTime.parse(map['checkoutDate']),
      // totalAmount: (map['totalAmount'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'customerName': customerName,
      'phoneNo': phoneNo,
      'email': email,
      'adultCount': adultCount,
      'childrenCount': childrenCount,
      'roomType': roomType.name,  // Assuming roomType is an enum
      'roomCount': roomCount,
      'checkinDate': checkinDate.toIso8601String(),
      'checkoutDate': checkoutDate.toIso8601String(),
      // 'totalAmount': totalAmount,
    };
  }

}
