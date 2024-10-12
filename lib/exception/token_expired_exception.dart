import 'package:hotel_manager/exception/base_exception.dart';

class TokenExpiredException extends BaseException{
  TokenExpiredException(String? message) : super(message: message);

  @override
  String toString() => message ?? super.toString();
}