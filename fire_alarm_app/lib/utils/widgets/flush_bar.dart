import 'package:another_flushbar/flushbar.dart';
import 'package:fire_alarm_app/main.dart';
import 'package:fire_alarm_app/utils/font_data.dart';
import 'package:flutter/material.dart';

class FlushBar {
  showFlushbar({
    String? title,
    String? message,
    String? titleText,
    String? messageText,
  }) {
    return Flushbar(
      title: title,
      titleColor: Colors.black,
      message: message,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: Colors.white,
      // boxShadows: [
      //   BoxShadow(
      //       color: Colors.blue[800]!,
      //       offset: const Offset(0.0, 2.0),
      //       blurRadius: 3.0)
      // ],
      // backgroundGradient:
      //     const LinearGradient(colors: [Colors.blueGrey, Colors.black]),
      isDismissible: false,
      duration: const Duration(seconds: 3),
      // icon: const Icon(
      //   Icons.warning,
      //   color: Colors.orange,
      // ),
      showProgressIndicator: true,
      progressIndicatorBackgroundColor: Colors.orange,
      titleText: Text(titleText ?? "", style: FontData.dMSans20Bold()),

      messageText: Text(
        messageText ?? "",
        style: FontData.dMSans16Bold(fontWeight: FontWeight.normal),
      ),
    )..show(StateManager.navigatorKey.currentContext!);
  }
}
