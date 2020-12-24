import 'package:flutter/material.dart';
import 'package:half_body_fox/resource/color_resource.dart';
import 'package:half_body_fox/util/ui_tools.dart';
import 'package:half_body_fox/ext/ext.dart';

class SimpleSelector extends StatelessWidget {
  var isSelection;
  double iconWidth;

  SimpleSelector({
    Key key,
    this.isSelection = false,
    this.iconWidth,
  }) : super(key: key) {
    this.iconWidth = iconWidth ?? 15.w;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: iconWidth,
      width: iconWidth,
      decoration: isSelection
          ? imagesBG("images/ic_selected.webp")
          : getCornersDecoration(strokeWidth: 1.w, strokeColor: color_gray99, circular: iconWidth),
    );
  }
}
