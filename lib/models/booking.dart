import 'package:hotel_manager/models/reservation.dart';

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
  double totalAmount;
  DateTime? createdAt;

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
    this.totalAmount = 0,
    this.createdAt,
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
      'roomType': {
        'id' : roomType.getTypeId(),
      },
      'roomCount': roomCount,
      'checkinDate': checkinDate.toIso8601String().split('T').first,
      'checkoutDate': checkoutDate.toIso8601String().split('T').first,
      'roomList': rooms.map((room) => room.toMap()).toList(),
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
      roomType: RoomType.values.firstWhere((type) => type.getRoomTypeAsString() == map['roomType']!['type']!),
      roomCount: map['roomCount'],
      checkinDate: DateTime.parse(map['checkinDate']),
      checkoutDate: DateTime.parse(map['checkoutDate']),
      rooms: List<Room>.from(map['roomList']?.map((x) => Room.fromMap(x))),
      totalAmount: map['roomCount']! * map['roomType']!['price']!,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  factory Booking.fromReservation(Reservation reservation, List<Room> rooms) {
    return Booking(
      id: reservation.id,
      customerName: reservation.customerName,
      phoneNo: reservation.phoneNo,
      email: reservation.email,
      adultCount: reservation.adultCount,
      childrenCount: reservation.childrenCount,
      roomType: reservation.roomType,
      roomCount: reservation.roomCount,
      checkinDate: reservation.checkinDate,
      checkoutDate: reservation.checkoutDate,
      rooms: rooms,
      totalAmount: 0,
    );
  }
}
