import 'package:hotel_manager/enum/room_type.dart';

class Room {
  final int id;
  final String roomNo;
  final RoomType roomType;

  Room({
    required this.id,
    required this.roomNo,
    required this.roomType,
  });
}
