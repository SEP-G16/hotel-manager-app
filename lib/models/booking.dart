import '../enum/room_type.dart';
import '../models/room.dart';

class Booking {
  final int id;
  final String customerName;
  final String phoneNo;
  final String email;
  final int adultCount;
  final int childrenCount;
  final RoomType roomType;
  final int roomCount;
  final DateTime checkinDate;
  final DateTime checkoutDate;
  final List<Room> rooms;
  final double totalAmount;

  Booking({
    required this.id,
    required this.customerName,
    required this.phoneNo,
    required this.roomType,
    required this.roomCount,
    required this.checkinDate,
    required this.checkoutDate,
    required this.adultCount,
    required this.childrenCount,
    required this.email,
    required this.rooms,
    required this.totalAmount,
  });

  // Convert Booking object to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerName': customerName,
      'phoneNo': phoneNo,
      'email': email,
      'adultCount': adultCount,
      'childrenCount': childrenCount,
      'roomType': roomType.index,
      'roomCount': roomCount,
      'checkinDate': checkinDate.toIso8601String(),
      'checkoutDate': checkoutDate.toIso8601String(),
      'rooms': rooms.map((room) => room.toMap()).toList(),
      'totalAmount': totalAmount,
    };
  }

  // Create Booking object from Map
  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'],
      customerName: map['customerName'],
      phoneNo: map['phoneNo'],
      email: map['email'],
      adultCount: map['adultCount'],
      childrenCount: map['childrenCount'],
      roomType: RoomType.values[map['roomType']],
      roomCount: map['roomCount'],
      checkinDate: DateTime.parse(map['checkinDate']),
      checkoutDate: DateTime.parse(map['checkoutDate']),
      rooms: List<Room>.from(map['rooms']?.map((x) => Room.fromMap(x))),
      totalAmount: map['totalAmount'],
    );
  }
}
