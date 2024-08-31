enum RoomType{
  Standard, Deluxe, Family
}

extension RoomTypeExtension on RoomType{
  String getRoomTypeAsString()
  {
    return this.toString().split('.').last;
  }
}