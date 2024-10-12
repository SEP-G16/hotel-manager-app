import 'package:hotel_manager/exception/base_exception.dart';

class GenderNotFoundException extends BaseException{
  GenderNotFoundException(String? message) : super(message: message);

  @override
  String toString() => message ?? super.toString();
}