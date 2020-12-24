import 'package:flutter/material.dart';
import 'package:half_body_fox/resource/color_resource.dart';
import 'package:half_body_fox/ext/ext.dart';
import 'package:half_body_fox/resource/string_resource.dart';

enum EmptyViewType {
  ORDER_LIST_EMPTY,
}

class EmptyView extends StatelessWidget {
  EmptyViewType type;

  EmptyView({this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: color_white,
      padding: EdgeInsets.only(top: 102.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(getImagePath(), width: double.infinity, height: 180.w),
          getHintText().intoText(textColor: color_gray99, textSize: 12.w).intoPadding(EdgeInsets.only(top: 12.w))
        ],
      ),
    );
  }

  String getImagePath() {
    switch (type) {
      case EmptyViewType.ORDER_LIST_EMPTY:
      default:
        return "images/ic_empty_order_list.webp";
    }
  }

  String getHintText() {
    switch (type) {
      case EmptyViewType.ORDER_LIST_EMPTY:
      default:
        return text_emptyOrderList;
    }
  }
}
