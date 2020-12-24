import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:half_body_fox/resource/color_resource.dart';
import 'package:half_body_fox/util/logger_util.dart';
import 'package:half_body_fox/ext/ext.dart';

double getPhysicalWidth() => window.physicalSize.width;

///顶部状态栏高度 用于不使用appbar的页面
double stateBarHeight = MediaQueryData.fromWindow(window).padding.top;
double bottomBarHeight = MediaQueryData.fromWindow(window).padding.bottom;

///减价标签背景图
BoxDecoration getDiscountDecoration() => getGradientBG(color_startRed, color_endRed, radiusBL: 80.w, radiusTR: 12.w);

///渐变色背景
BoxDecoration getGradientBG(
  Color startColor,
  Color endColor, {
  Key key,
  TileMode tileMode = TileMode.repeated,
  Alignment begin = Alignment.centerLeft,
  Alignment end = Alignment.centerRight,
  BorderRadius radius,
  double radiusTL = 0,
  double radiusTR = 0,
  double radiusBL = 0,
  double radiusBR = 0,
}) {
  return  BoxDecoration(
    gradient: LinearGradient(
      begin: begin,
      end: end,
      colors: <Color>[startColor, endColor],
      tileMode: tileMode,
    ),
    borderRadius: radius ??
        BorderRadius.only(
          topLeft: Radius.circular(radiusTL),
          bottomLeft: Radius.circular(radiusBL),
          topRight: Radius.circular(radiusTR),
          bottomRight: Radius.circular(radiusBR),
        ),
  );
}

///图片背景
BoxDecoration imagesBG(String path) {
  return BoxDecoration(
      image: DecorationImage(
    image: ExactAssetImage(path),
    fit: BoxFit.fill,
  ));
}

///未读背景框
BoxDecoration getUnReadBoxDecoration(int unReadCount, {Key key, Color bgColor = color_mainRed, Color funStrokeColor = color_white}) {
  var strokeColor = unReadCount == 0 ? Color(0x00ffffff) : funStrokeColor;
  var centerColor = unReadCount == 0 ? Color(0x00ffffff) : bgColor;
  return BoxDecoration(
      shape: BoxShape.rectangle,
      border: new Border.all(color: strokeColor, width: 1.w), // 边色与边宽度
      borderRadius: BorderRadius.all(Radius.circular(100.w)),
      color: centerColor);
}

///colorString 解析为 16进制
Color hexColor(String colorString, {Color defColor = Colors.transparent}) {
  print("inputColor = $colorString");
  try {
    return Color(int.parse(colorString.replaceAll("#", ""), radix: 16) + 0xFF000000);
  } catch (e) {
    logger.e(e);
    return defColor;
  }
}

BorderSide singleBorderSide({double width, Color color, BorderStyle style = BorderStyle.solid}) =>
    BorderSide(color: color, width: width, style: style);

BoxDecoration getCornersDecoration({
  Key key,
  Color bgColor = color_transparent,
  Color strokeColor = color_transparent,
  double strokeWidth = 1,
  double circular = 0,
  BorderRadius borderRadius,
}) {
  return BoxDecoration(
      shape: BoxShape.rectangle,
      border: new Border.all(color: strokeColor, width: strokeWidth),
      // 边色与边宽度
      borderRadius: borderRadius == null ? BorderRadius.all(Radius.circular(circular)) : borderRadius,
      color: bgColor);
}

showIosDialog(
  BuildContext context, {
  Widget content,
  String positiveText,
  String negativeText,
  Function positiveListener,
  Function negativeListener,
}) async {
  return await showDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      content: content,
      actions: <Widget>[
        negativeText.isNullOrBlank()
            ? Container()
            : CupertinoDialogAction(
                child: negativeText.intoText(textColor: color_mainBlue, textSize: 17.w),
                onPressed: () => negativeListener == null ? Navigator.of(context).pop() : negativeListener()),
        positiveText.isNullOrBlank()
            ? Container()
            : CupertinoDialogAction(
                child: positiveText.intoText(textColor: color_mainBlue, textSize: 17.w), onPressed: () => positiveListener?.call()),
      ],
    ),
  );
}

BoxDecoration borderSides({
  BorderSide top = BorderSide.none,
  BorderSide bottom = BorderSide.none,
  BorderSide left = BorderSide.none,
  BorderSide right = BorderSide.none,
  Color color = Colors.white,
  BoxShape shape = BoxShape.rectangle,
}) =>
    BoxDecoration(shape: shape, color: color, border: Border(left: left, top: top, bottom: bottom, right: right));
