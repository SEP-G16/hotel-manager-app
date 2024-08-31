import 'package:flutter/cupertino.dart';

abstract class BaseException implements Exception{
  @protected
  String? message;

  BaseException({this.message});

  @override
  String toString();
}