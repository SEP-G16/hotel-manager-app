import 'package:get/get.dart';
import 'package:flutter/material.dart';

class BookingTabController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  RxInt _selectedIndex = 0.obs;
  RxString _selectedRoomType = 'All'.obs; // Track selected room type

  int get selectedIndex => _selectedIndex.value;
  String get selectedRoomType => _selectedRoomType.value;

  final RxList<Map<String, String>> _temporaryRooms = <Map<String, String>>[].obs;
  final RxList<Map<String, String>> _confirmedRooms = <Map<String, String>>[].obs;

  List<String> get filteredTemporaryRooms {
    if (selectedRoomType == 'All') {
      return _temporaryRooms.map((room) => room['number']!).toList();
    }
    return _temporaryRooms.where((room) => room['type'] == selectedRoomType).map((room) => room['number']!).toList();
  }

  List<String> get filteredConfirmedRooms {
    if (selectedRoomType == 'All') {
      return _confirmedRooms.map((room) => room['number']!).toList();
    }
    return _confirmedRooms.where((room) => room['type'] == selectedRoomType).map((room) => room['number']!).toList();
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);

    // Initialize room data
    _temporaryRooms.addAll([
      {'number': 'Room No. : 21', 'type': 'Standard'},
      {'number': 'Room No. : 22', 'type': 'Standard'},
      {'number': 'Room No. : 23', 'type': 'Standard'},
      {'number': 'Room No. : 24', 'type': 'Deluxe'},
      {'number': 'Room No. : 25', 'type': 'Deluxe'},
      {'number': 'Room No. : 26', 'type': 'Family'},
      {'number': 'Room No. : 27', 'type': 'Family'},
    ]);

    _confirmedRooms.addAll([
      {'number': 'Room No. : 10', 'type': 'Standard'},
      {'number': 'Room No. : 11', 'type': 'Deluxe'},
      {'number': 'Room No. : 14', 'type': 'Family'},
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
}
