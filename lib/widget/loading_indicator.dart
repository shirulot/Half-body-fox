import 'package:flutter/material.dart';
import 'package:half_body_fox/ext/ext.dart';

class MiniLoadingIndicator extends StatelessWidget {
  double height;

  double width;

  MiniLoadingIndicator({this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height ?? 30.w,
        width: width ?? 30.w,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
