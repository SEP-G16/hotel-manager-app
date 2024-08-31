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

  // Convert Room object to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'roomNo': roomNo,
      'roomType': roomType.index,
    };
  }

  // Create Room object from Map
  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      id: map['id'],
      roomNo: map['roomNo'],
      roomType: RoomType.values[map['roomType']],
    );
  }
}
