import 'package:hotel_manager/exception/base_exception.dart';

class TokenNotFoundException extends BaseException{
  TokenNotFoundException(String? message) : super(message: message);

  @override
  String toString() => message ?? super.toString();
}