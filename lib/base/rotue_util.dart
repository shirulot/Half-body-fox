import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RouteUtil {
  ///打开新页面
  static openNewPage(Widget widget, BuildContext context) async {
    int coordinates = await Navigator.of(context).push(
      // MaterialPageRoute 是Material组件库的一个Widget，它可以针对不同平台，实现与平台页面切换动画风格一致的路由切换动画：
      new MaterialPageRoute(
        builder: (context) {
          return widget;
        },
      ),
    );
    if (coordinates == 100) {
      print("coordinates == 100");
    }
  }
}
