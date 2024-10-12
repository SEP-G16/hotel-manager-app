import 'package:hotel_manager/enum/room_type.dart';

class Room {
  final int id;
  final int roomNo;
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
      'roomType': {
        'id': roomType.getTypeId(),
      },
    };
  }

  // Create Room object from Map
  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      id: map['id'],
      roomNo: map['roomNo'],
      roomType: RoomType.values.firstWhere((roomType) => roomType.getRoomTypeAsString() == map['roomType']['type']),
    );
  }

  factory Room.fromAvailabilityMap(Map<String, dynamic> map) {
    return Room(
      id: map['roomId'],
      roomNo: map['roomNo'],
      roomType: RoomType.values.firstWhere((roomType) => roomType.getRoomTypeAsString() == map['roomType']),
    );
  }
}
