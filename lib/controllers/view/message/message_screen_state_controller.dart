import 'package:get/get.dart';
import 'package:hotel_manager/controllers/data/customer_message_data_controller.dart';
import 'package:hotel_manager/controllers/data/customer_message_data_controller.dart';
import 'package:hotel_manager/models/support_ticket.dart';

class MessageScreenStateController extends GetxController{
  static MessageScreenStateController instance = Get.find();

  final CustomerMessageDataController _cmdc = CustomerMessageDataController.instance;

  RxList<SupportTicket> _ticketList = <SupportTicket>[].obs;
  List<SupportTicket> get ticketList => _ticketList;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _ticketList.assignAll(_cmdc.tickets);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    ever(_cmdc.listenableSupportTickets, (value){
      _ticketList.assignAll(value);
    });
  }

  Future<void> getSupportTickets() async {
    await _cmdc.reInitController();
  }
}