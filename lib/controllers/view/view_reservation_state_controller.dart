import 'package:get/get.dart';
import 'package:hotel_manager/controllers/data/booking_data_controller.dart';
import 'package:hotel_manager/enum/room_type.dart';
import 'package:hotel_manager/models/reservation.dart';
import 'package:hotel_manager/models/room.dart';

class ViewReservationStateController extends GetxController{

  static final ViewReservationStateController instance = Get.find();

  BookingDataController _bdc = BookingDataController.instance;

  RxString _availability = ''.obs;
  String get availability => _availability.value;

  RxList<Room> _roomList = <Room>[].obs;
  List<Room> get roomList => _roomList;

  RxList<Room> _selectedRoomList = <Room>[].obs;
  List<Room> get selectedRoomList => _selectedRoomList;


  Future<String> getAvailabilityStatus({required DateTime from, required DateTime to, required RoomType roomType}) async {
    _availability.value =  await _bdc.getAvailabilityStatus(from, to, roomType);
    return _availability.value;
  }

  Future<List<Room>> getAvailableRoomsList({required DateTime from, required DateTime to, required RoomType roomType}) async {
    List<Room> availableRooms = await  _bdc.getAvailableRoomsList(from, to, roomType);
    _roomList.assignAll(availableRooms);
    return availableRooms;
  }

  void addRoomToSelected({required int roomId})
  {
    _selectedRoomList.add(_roomList.firstWhere((room) => room.id == roomId));
  }

  void removeRoomFromSelected({required int roomId})
  {
    _selectedRoomList.removeWhere((room) => room.id == roomId);
  }

  Future<void> addBooking({required Reservation reservation}) async {
    await _bdc.addBookingByReservation(reservation : reservation, roomList: _selectedRoomList);
    reinitController();
  }

  void reinitController() async {
    _selectedRoomList.clear();
    _roomList.clear();
  }
}