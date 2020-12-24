import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:half_body_fox/resource/color_resource.dart';

class ToastUtil {
  static showSnackBar(BuildContext context, String text) {
    ///隐藏前一次的snackBar
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(
      new SnackBar(
        content: SizedBox.fromSize(
          size: Size(double.infinity, 20),
          child: Align(alignment: Alignment.centerLeft, child: Text(text)),
        ),
      ),
    );
  }

  static showT(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(0x99000000),
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

log(String log) {
  print(log);
}
