import 'package:get/get.dart';
import 'booking_tab_controller.dart';

class AddReservationViewStateController extends GetxController {
  static AddReservationViewStateController get instance => Get.find();

  // Properties
  RxString _selectedValue = '-1'.obs;
  String get selectedValue => _selectedValue.value;
  set selectedValue(String value) => _selectedValue.value = value;

  RxString _selectedCategory = 'Select'.obs;
  String get selectedCategory => _selectedCategory.value;
  set selectedCategory(String value) => _selectedCategory.value = value;

  Rx<DateTime> _selectedDate = DateTime.now().obs;
  DateTime get selectedDate => _selectedDate.value;
  set selectedDate(DateTime value) => _selectedDate.value = value;

  Rx<DateTime> _checkOutDate = DateTime.now().add(Duration(days: 1)).obs;
  DateTime get checkOutDate => _checkOutDate.value;
  set checkOutDate(DateTime value) => _checkOutDate.value = value;

  RxString _name = ''.obs;
  String get name => _name.value;
  set name(String value) => _name.value = value;

  RxString _selectedAdultCount = '1'.obs; // Default to 1
  String get selectedAdultCount => _selectedAdultCount.value;
  set selectedAdultCount(String value) => _selectedAdultCount.value = value;

  RxString _selectedChildCount = '0'.obs; // Default to 0
  String get selectedChildCount => _selectedChildCount.value;
  set selectedChildCount(String value) => _selectedChildCount.value = value;

  // Method to add the room directly to the confirmed list in BookingTabController
  void addRoomToConfirmedList() {
    // Create a Room object based on current state
    Room room = Room(
      number: 'Room Number : 16', // Example room number, update as needed
      type: selectedCategory,
      checkInDate: selectedDate,
      checkOutDate: checkOutDate,
      adults: int.parse(selectedAdultCount),
      children: int.parse(selectedChildCount),
      roomCount: int.parse(selectedValue),
    );

    // Get the instance of BookingTabController and add the room
    BookingTabController bookingTabController = Get.find();
    bookingTabController.moveRoomToConfirmed(room);
  }
}
