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

  final double totalAmount;

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
    required this.totalAmount,
  });
}
