import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingDialog {
  LoadingDialog({this.callerFunction, this.onErrorCallBack, this.onSuccessCallBack}) {
    _loadingDialog();
  }

  final FutureOr<void> Function()? callerFunction;
  final void Function(Object? error)? onErrorCallBack;
  final void Function()? onSuccessCallBack;

  void _loadingDialog() async {
    Get.dialog(
      LayoutBuilder(builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: constraints.maxHeight, minWidth: constraints.maxWidth),
          child: Container(
            alignment: Alignment.center,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      }),
      barrierDismissible: false,
    );
    if (callerFunction != null) {
      try {
        await callerFunction!();
        print('Exited');
        Get.back(); //close loading dialog
        if (onSuccessCallBack != null) {
          onSuccessCallBack!();
        }
      } catch (e) {
        Get.back();
        if (onErrorCallBack != null) {
          onErrorCallBack!(e);
        }
      }
    } else {
      Get.back();
    }
  }
}