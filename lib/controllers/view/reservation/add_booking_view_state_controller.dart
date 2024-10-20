import 'package:get/get.dart';
import 'package:hotel_manager/controllers/data/booking_data_controller.dart';
import 'package:hotel_manager/models/booking.dart';
import 'package:hotel_manager/models/form_valid_response.dart';
import 'package:hotel_manager/models/room.dart';
import '../../../enum/room_type.dart';
import 'booking_tab_controller.dart';

class AddBookingViewStateController extends GetxController {
  static AddBookingViewStateController get instance => Get.find();

  final RegExp _nameRegExp = RegExp(r"^[a-zA-Z\s'-]+$");
  final RegExp _phoneRegExp =
      RegExp(r"^\+?(\d[\d-. ]+)?(\([\d-. ]+\))?[\d-. ]+\d$");
  final RegExp _emailRegExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

  final BookingDataController _bdc = BookingDataController.instance;

  RxString _selectedCategory = RoomType.Standard.name.obs;

  String get selectedCategory => _selectedCategory.value;

  set selectedCategory(String value) => _selectedCategory.value = value;

  Rx<DateTime> _checkInDate = DateTime.now().obs;

  DateTime get checkInDate => _checkInDate.value;

  set checkInDate(DateTime value) => _checkInDate.value = value;

  Rx<DateTime> _checkOutDate = DateTime.now().add(Duration(days: 1)).obs;

  DateTime get checkOutDate => _checkOutDate.value;

  set checkOutDate(DateTime value) => _checkOutDate.value = value;

  RxString _name = ''.obs;

  String get name => _name.value;

  set name(String value) => _name.value = value;

  RxString _phoneNo = ''.obs;

  String get phoneNo => _phoneNo.value;

  set phoneNo(String value) => _phoneNo.value = value;

  RxString _email = ''.obs;

  String get email => _email.value;

  set email(String value) => _email.value = value;

  RxString _selectedAdultCount = '1'.obs; // Default to 1
  String get selectedAdultCount => _selectedAdultCount.value;

  set selectedAdultCount(String value) => _selectedAdultCount.value = value;

  RxString _selectedChildrenCount = '0'.obs; // Default to 0
  String get selectedChildrenCount => _selectedChildrenCount.value;

  set selectedChildrenCount(String value) =>
      _selectedChildrenCount.value = value;

  RxString _selectedRoomCount = '1'.obs;

  String get selectedRoomCount => _selectedRoomCount.value;

  set selectedRoomCount(String value) {
    _selectedRoomCount.value = value;
  }

  RxString _availability = 'Fetching'.obs;

  String get availability => _availability.value;

  RxList<Room> _roomList = <Room>[].obs;

  List<Room> get roomList => _roomList;

  RxList<Room> _selectedRoomList = <Room>[].obs;

  List<Room> get selectedRoomList => _selectedRoomList;

  // Method to add the room directly to the confirmed list in BookingTabController
  void addRoomToConfirmedList() {
    // Create a Room object based on current state
    // Room room = Room(
    //   number: 'Room Number : 16', // Example room number, update as needed
    //   type: selectedCategory,
    //   checkInDate: checkInDate,
    //   checkOutDate: checkOutDate,
    //   adults: int.parse(selectedAdultCount),
    //   children: int.parse(selectedChildCount),
    //   roomCount: int.parse(selectedValue),
    // );

    // Get the instance of BookingTabController and add the room
    // BookingTabController bookingTabController = Get.find();
    // bookingTabController.moveReservationToConfirmed(room);
  }

  Future<String> getAvailabilityStatus(
      {required DateTime from,
      required DateTime to,
      required RoomType roomType,
      int? expectedRoomCount}) async {
    try {
      _availability.value = 'Fetching';
      _availability.value = await _bdc.getAvailabilityStatus(from, to, roomType,
          expectedCount: expectedRoomCount);
      return _availability.value;
    } catch (e) {
      _availability.value = 'Error';
      return _availability.value;
    }
  }

  Future<List<Room>> getAvailableRoomsList() async {
    List<Room> availableRooms = await _bdc.getAvailableRoomsList(
        _checkInDate.value,
        _checkOutDate.value,
        RoomType.fromString(_selectedCategory.value));
    _roomList.assignAll(availableRooms);
    return availableRooms;
  }

  void addRoomToSelected({required int roomId}) {
    _selectedRoomList.add(_roomList.firstWhere((room) => room.id == roomId));
  }

  void removeRoomFromSelected({required int roomId}) {
    _selectedRoomList.removeWhere((room) => room.id == roomId);
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getAvailabilityStatus(
        from: _checkInDate.value,
        to: _checkOutDate.value,
        roomType: RoomType.Standard);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    ever(_selectedCategory, (value) async {
      await getAvailabilityStatus(
          from: _checkInDate.value,
          to: _checkOutDate.value,
          roomType: RoomType.fromString(value),
          expectedRoomCount: int.parse(selectedRoomCount));
    });

    ever(_checkInDate, (value) async {
      await getAvailabilityStatus(
          from: value,
          to: _checkOutDate.value,
          roomType: RoomType.fromString(selectedCategory),
          expectedRoomCount: int.parse(selectedRoomCount));
    });

    ever(_checkOutDate, (value) async {
      await getAvailabilityStatus(
          from: _checkInDate.value,
          to: value,
          roomType: RoomType.fromString(selectedCategory),
          expectedRoomCount: int.parse(selectedRoomCount));
    });

    ever(_selectedRoomCount, (value) async {
      await getAvailabilityStatus(
          from: _checkInDate.value,
          to: _checkOutDate.value,
          roomType: RoomType.fromString(selectedCategory),
          expectedRoomCount: int.parse(value));
    });
  }

  FormValidResponse validateForm() {
    final validationRules = [
      {
        'condition': _name.value.isEmpty,
        'message': 'Name cannot be empty!',
      },
      {
        'condition': !_nameRegExp.hasMatch(_name.value),
        'message': 'Name is not valid!',
      },
      {
        'condition': _phoneNo.value.isEmpty,
        'message': 'Phone Number cannot be empty!',
      },
      {
        'condition': !_phoneRegExp.hasMatch(_phoneNo.value),
        'message': 'Phone Number is not valid!',
      },
      {
        'condition': _email.value.isEmpty,
        'message': 'Email cannot be empty!',
      },
      {
        'condition': !_emailRegExp.hasMatch(_email.value),
        'message': 'Email is not valid!',
      },
      {
        'condition': _selectedAdultCount.value == '0',
        'message': 'At least one adult is required!',
      },
      {
        'condition': _selectedRoomCount.value == '0',
        'message': 'At least one room must be selected!',
      },
      {
        'condition': _checkInDate.value.isAfter(_checkOutDate.value),
        'message': 'Check-in date cannot be after check-out date!',
      },
    ];

    for (final rule in validationRules) {
      if (rule['condition'] as bool) {
        return FormValidResponse(
            formValid: false, message: rule['message'] as String);
      }
    }

    return FormValidResponse(formValid: true);
  }

  Future<void> addBooking() async {
    Booking booking = Booking(
      id: -1,
      customerName: _name.value,
      phoneNo: _phoneNo.value,
      email: _email.value,
      checkinDate: _checkInDate.value,
      checkoutDate: _checkOutDate.value,
      adultCount: int.parse(_selectedAdultCount.value),
      childrenCount: int.parse(_selectedChildrenCount.value),
      roomCount: int.parse(_selectedRoomCount.value),
      rooms: _selectedRoomList,
      roomType: RoomType.fromString(_selectedCategory.value),
    );
    await _bdc.addBookingByBooking(booking: booking);
  }

  void reInitController() {
    _selectedCategory.value = RoomType.Standard.name;
    _checkInDate.value = DateTime.now();
    _checkOutDate.value = DateTime.now().add(Duration(days: 1));
    _name.value = '';
    _phoneNo.value = '';
    _email.value = '';
    _selectedAdultCount.value = '1';
    _selectedChildrenCount.value = '0';
    _selectedRoomCount.value = '1';
    _availability.value = 'Fetching';
    _roomList.clear();
    _selectedRoomList.clear();
  }
}
