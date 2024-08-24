import 'package:get/get.dart';
import 'package:flutter/material.dart';

class BookingTabController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  RxInt _selectedIndex = 0.obs;
  RxString _selectedRoomType = 'All'.obs;

  int get selectedIndex => _selectedIndex.value;
  String get selectedRoomType => _selectedRoomType.value;

  final RxList<Room> _temporaryRooms = <Room>[].obs;
  final RxList<Room> _confirmedRooms = <Room>[].obs;

  List<Room> get filteredTemporaryRooms {
    if (selectedRoomType == 'All') {
      return _temporaryRooms;
    }
    return _temporaryRooms.where((room) => room.type == selectedRoomType).toList();
  }

  List<Room> get filteredConfirmedRooms {
    if (selectedRoomType == 'All') {
      return _confirmedRooms;
    }
    return _confirmedRooms.where((room) => room.type == selectedRoomType).toList();
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);

    // Initialize room data
    _temporaryRooms.addAll([
      Room(number: 'Room Number : 21', type: 'Standard', checkInDate: DateTime.now(), checkOutDate: DateTime.now().add(Duration(days: 1)), adults: 2, children: 1, roomCount: 1),
      Room(number: 'Room Number : 22', type: 'Standard', checkInDate: DateTime.now(), checkOutDate: DateTime.now().add(Duration(days: 1)), adults: 2, children: 0, roomCount: 1),
      Room(number: 'Room Number : 23', type: 'Standard', checkInDate: DateTime.now(), checkOutDate: DateTime.now().add(Duration(days: 2)), adults: 1, children: 0, roomCount: 1),
      Room(number: 'Room Number : 24', type: 'Deluxe', checkInDate: DateTime.now(), checkOutDate: DateTime.now().add(Duration(days: 3)), adults: 2, children: 2, roomCount: 1),
      Room(number: 'Room Number : 25', type: 'Deluxe', checkInDate: DateTime.now(), checkOutDate: DateTime.now().add(Duration(days: 1)), adults: 3, children: 1, roomCount: 2),
      Room(number: 'Room Number : 26', type: 'Family', checkInDate: DateTime.now(), checkOutDate: DateTime.now().add(Duration(days: 2)), adults: 2, children: 3, roomCount: 1),
      Room(number: 'Room Number : 27', type: 'Family', checkInDate: DateTime.now(), checkOutDate: DateTime.now().add(Duration(days: 1)), adults: 2, children: 2, roomCount: 1),
    ]);

    _confirmedRooms.addAll([
      Room(number: 'Room Number : 10', type: 'Standard', checkInDate: DateTime.now().subtract(Duration(days: 1)), checkOutDate: DateTime.now(), adults: 2, children: 1, roomCount: 1),
      Room(number: 'Room Number : 11', type: 'Deluxe', checkInDate: DateTime.now().subtract(Duration(days: 1)), checkOutDate: DateTime.now(), adults: 1, children: 0, roomCount: 1),
      Room(number: 'Room Number : 14', type: 'Family', checkInDate: DateTime.now().subtract(Duration(days: 2)), checkOutDate: DateTime.now().subtract(Duration(days: 1)), adults: 2, children: 2, roomCount: 1),
    ]);

    tabController.addListener(() {
      _selectedIndex.value = tabController.index;
      print(selectedIndex);
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void updateSelectedRoomType(String roomType) {
    _selectedRoomType.value = roomType;
    update(); // Notify listeners to rebuild
  }

  // Method to move room from temporary to confirmed
  void moveRoomToConfirmed(Room room) {
    _temporaryRooms.remove(room);
    _confirmedRooms.add(room);
    update(); // Notify listeners to rebuild
  }

  void rejectReservation(Room room){
    _temporaryRooms.remove(room);
    update();
  }

  void cancelReservation(Room room){
    _confirmedRooms.remove(room);
    update();
  }
}

class Room {
  final String number;
  final String type;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int adults;
  final int children;
  final int roomCount;

  Room({
    required this.number,
    required this.type,
    required this.checkInDate,
    required this.checkOutDate,
    required this.adults,
    required this.children,
    required this.roomCount,
  });
}
