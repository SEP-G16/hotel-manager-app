import 'package:get/get.dart';
import 'package:hotel_manager/controllers/data/customer_message_data_controller.dart';

class MessageStateController extends GetxController{
  static MessageStateController instance = Get.find();

  final CustomerMessageDataController _cmdc = CustomerMessageDataController.instance;

  String? _message = '';
  String? get message => _message;
  set message(String? message) => _message = message;

  Future<void> sendMessage(int ticketId) async {
    await _cmdc.sendMessage(_message!, ticketId);
  }
}