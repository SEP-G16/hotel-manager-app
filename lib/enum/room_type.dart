enum RoomType{
  Standard, Deluxe, Suite
}

extension RoomTypeExtension on RoomType{
  String getRoomTypeAsString()
  {
    return this.toString().split('.').last;
  }

  int getTypeId()
  {
    return this.index+1;
  }
}