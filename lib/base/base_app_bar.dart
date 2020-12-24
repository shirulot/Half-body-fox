import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:half_body_fox/ext/ext.dart';

///顶部栏
class BaseAppBar {
//  BuildContext context;
//  List<Widget> rightButtons;
//  dynamic title;
//
//  BaseAppBar(BuildContext context, {Key key, this.title, this.rightButtons});
  //左侧返回事件
  static void back(BuildContext context) {
    var canPop = Navigator.canPop(context);
    if (canPop) {
      Navigator.pop(context);
    } else {
      SystemNavigator.pop();
    }
  }

  static Widget build(
    BuildContext context, {
    Key key,
    Widget backIcon,
    dynamic title,
    List<Widget> rightButtons,
    Widget tabBar,
    Color backColor,
    Color titleTextColor,
    Color backgroundColor = Colors.white,
  }) {
    return AppBar(
      key: key,
      title: title is Widget
          ? title
          : "$title".intoText(textColor: titleTextColor ?? Colors.black, textSize: 20.w, textAlign: TextAlign.center, maxLine: 1),
      bottom: tabBar,
      elevation: 0,

      actions: rightButtons,
      centerTitle: true,
      backgroundColor: backgroundColor,
      leading: backIcon ??
          IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 18.w, color: backColor),
            onPressed: () => back(context),
            padding: EdgeInsets.zero,
            iconSize: 10.w,
          ),
      iconTheme: IconThemeData.fallback(),
    );
  }
}
