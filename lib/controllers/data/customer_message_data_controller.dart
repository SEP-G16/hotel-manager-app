import 'package:get/get.dart';
import 'package:hotel_manager/controllers/network/customer_message_network_controller.dart';
import 'package:hotel_manager/models/support_ticket.dart';

class CustomerMessageDataController extends GetxController{

  final CustomerMessageNetworkController _cmnc = CustomerMessageNetworkController.instance;

  static CustomerMessageDataController instance = Get.find();

  List<SupportTicket> _tickets = [];
  List<SupportTicket> get tickets => _tickets;
  RxList<SupportTicket> listenableSupportTickets = <SupportTicket>[].obs;

  CustomerMessageDataController._();

  static Future<CustomerMessageDataController> create() async {
    CustomerMessageDataController controller = CustomerMessageDataController._();
    await controller._init();
    return controller;
  }

  Future<void> reInitController() async {
    await _init();
  }

  Future<void> _init() async {
    List<SupportTicket> all = await _getAllMessages();
    all.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    _tickets = all;
    listenableSupportTickets.assignAll(all);
  }

  Future<List<SupportTicket>> _getAllMessages() async {
    List<Map<String, dynamic>> messages = await _cmnc.getAllMessages();
    return messages.where((map) => (map['responses']! as List<dynamic>).isEmpty).toList().map((e) => SupportTicket.fromMap(e)).toList();
  }

  Future<void> sendMessage(String message, int ticketId) async {
    await _cmnc.sendResponse(message, ticketId);
    await reInitController();
  }
}