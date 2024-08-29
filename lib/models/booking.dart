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
}
