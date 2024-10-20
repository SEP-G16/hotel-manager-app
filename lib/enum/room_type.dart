enum RoomType{
  Standard, Deluxe, Suite;

  static RoomType fromString(String value)
  {
    return RoomType.values.firstWhere((element) => element.toString().split('.').last == value);
  }
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