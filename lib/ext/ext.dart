import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:half_body_fox/resource/color_resource.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:half_body_fox/util/base64_util.dart';
import 'package:half_body_fox/util/logger_util.dart';
import 'package:half_body_fox/util/ui_tools.dart';
import 'package:half_body_fox/util/date_util.dart';
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';
import 'package:intl/intl.dart';

Widget conditionsBuild(bool conditions, Widget target) {
  return conditions ? target : Container();
}

extension Ext on Widget {
  Widget intoCenter() {
    return Center(
      child: this,
    );
  }

  Widget clipRRect({double tl = 0, double tr = 0, double bl = 0, double br = 0}) {
    return ClipRRect(
      child: this,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(tl),
        bottomLeft: Radius.circular(bl),
        topRight: Radius.circular(tr),
        bottomRight: Radius.circular(br),
      ),
    );
  }

  Widget clipOval({double tl = 0, double tr = 0, double bl = 0, double br = 0}) {
    return ClipOval(
      child: this,
    );
  }

  Widget intoCard({double circular, EdgeInsetsGeometry margin}) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(circular ?? 4.w))),
      margin: margin,
      child: this,
    );
  }

  Widget intoPositioned({double left, double right, double top, double bottom, double width, double height}) {
    return Positioned(top: top, left: left, right: right, bottom: bottom, child: this, width: width, height: height);
  }

  Padding intoPadding(EdgeInsets padding) {
    return Padding(
      padding: padding,
      child: this,
    );
  }

  ///透明度 @param alp 0-1
  Opacity intoAlp(double alp) {
    return Opacity(opacity: alp, child: this);
  }

  Container intoMargin(EdgeInsets margin) {
    return Container(
      margin: margin,
      child: this,
    );
  }

  Container setBGColor(Color color) {
    return Container(
      color: color,
      child: this,
    );
  }

  Container setBG(bg) {
    if (bg is Color) {
      return this.setBGColor(bg);
    } else if (bg is Decoration) {
      return Container(decoration: bg, child: this);
    } else {
      return this;
    }
  }

  Align intoAlign(Alignment alignment) {
    return Align(
      alignment: alignment,
      child: this,
    );
  }

  ///是否隐藏当前布局 true为隐藏
  Offstage isGone(bool isGone) {
    return Offstage(
      offstage: isGone,
      child: this,
    );
  }

  Offstage isShow(bool isShow) {
    return this.isGone(!isShow);
  }

  Container setHeight(double height) {
    return Container(
      height: height,
      child: this,
    );
  }

  Container setWidth(double width) {
    return Container(
      width: width,
      child: this,
    );
  }

  ///满足条件则返回空控件 否则展示当前控件
  Widget isHide(bool isHide) => isHide ? Container() : this;

  Expanded intoExpanded({int flex}) {
    return Expanded(
      child: this,
      flex: flex,
    );
  }

  Widget removePadding(
    BuildContext context, {
    bool top = true,
    bool bottom = false,
    bool left = false,
    bool right = false,
  }) {
    return MediaQuery.removePadding(
      context: context,
      child: this,
      removeTop: top,
      removeBottom: bottom,
      removeLeft: left,
      removeRight: right,
    );
  }

  Widget setClickListener(Function fun, {HitTestBehavior behavior, bool opaque = true}) {
    if (opaque) behavior = HitTestBehavior.opaque;
    return GestureDetector(
      behavior: behavior,
      child: this,
      onTap: () => fun?.call(),
    );
  }

  ///如果将splashColor和highlightColor颜色置为一致 则可以取消水波纹点击效果 常用Colors.transparent
  Widget intoFlatButton(
    Function fun, {
    EdgeInsets padding = EdgeInsets.zero,
    Color color,
    Color splashColor,
    Color highlightColor,
    Color disabledColor,
  }) {
    return FlatButton(
      padding: padding,
      child: this,
      color: color,
      onPressed: () => fun?.call(),
      disabledColor: disabledColor,
      splashColor: splashColor,
      highlightColor: highlightColor,
    );
  }

  Widget setSize(double width, double height) {
    return SizedBox.fromSize(
      child: this,
      size: Size(width, height),
    );
  }
}

extension textExt on String {
  Text intoText({
    Color textColor = color_mainBlack,
    double textSize = 15,
    bool bold = false,
    TextAlign textAlign = TextAlign.left,
    bool deleteLine = false,
    int maxLine = 99,
    double height,
    FontWeight fontWeight = FontWeight.normal,
    TextWidthBasis textWidthBasis,
  }) {
    if (this == null) return Text("");
    return Text(
      this,
      textScaleFactor: 1,
      textAlign: textAlign,
      softWrap: maxLine != 1,
      textWidthBasis: textWidthBasis,
      style: TextStyle(
          color: textColor,
          fontSize: textSize,
          height: height,
          fontWeight: bold ? FontWeight.bold : fontWeight,
          decoration: deleteLine ? TextDecoration.lineThrough : TextDecoration.none),
      maxLines: maxLine,
      overflow: maxLine == 1 ? TextOverflow.ellipsis : null,
    );
  }

  TextSpan intoTextSpan({
    Color textColor = color_mainBlack,
    double textSize = 15,
    bool bold = false,
    bool deleteLine = false,
    double height,
    FontWeight fontWeight = FontWeight.normal,
    List<InlineSpan> children,
  }) {
    return TextSpan(
        text: this,
        style: TextStyle(
            color: textColor,
            fontSize: textSize,
            height: height,
            fontWeight: bold ? FontWeight.bold : fontWeight,
            decoration: deleteLine ? TextDecoration.lineThrough : TextDecoration.none),
        children: children);
  }

  String toMD5() {
    var content = new Utf8Encoder().convert(this);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes).trim();
  }

  String toBase64() {
    return Base64Util.encode(this ?? "");
  }

  String decodeBase64() {
    try {
      return Base64Util.decode(this ?? "");
    } catch (e) {
      return "";
    }
  }

  int tryToInt({int def = 0}) {
    try {
      return int.parse(this);
    } catch (e) {
      logger.e(e);
      return def;
    }
  }

  double tryToDouble({double def = 0}) {
    try {
      return double.parse(this);
    } catch (e) {
      logger.e(e);
      return def;
    }
  }
}

extension NumberExt on num {
  String limitPlus(int max) {
    if (this > max) {
      return "$max+";
    } else {
      return this.toString();
    }
  }

  num limit({num min = 0, num max = 999999999}) {
    if (this > max) {
      return max;
    } else if (this < min) {
      return min;
    } else {
      return this;
    }
  }

  String toStringKillZero() {
    if (this % 1 == 0) {
      return this.toInt().toString();
    } else {
      return this.toString();
    }
  }

  String toThousandMoney() {
    return NumberFormat("###,###.##").format(this);
  }

  String keep2KillZero() {
    if (this != null) {
      try {
        return double.parse(this.toStringAsFixed(2)).toStringKillZero();
      } catch (e) {
        logger.e(e);
      }
    }
    return "0";
  }

  String price() {
    return keep2KillZero();
  }

  // String toGetUMoney({String symbol}) {
  //   return "${symbol ?? User.getCurrencySymbol()}${this.price()}";
  // }

  String toGetUDate({int length = 5}) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(this.toInt());
    return formatDate(dateTime, length: length);
  }

//  num get w => this;

  /// 暂时赋值一份 日后需要变更统一更改
  ///[ScreenUtil.setWidth]
  num get w {
    try {
      return ScreenUtil().setWidth(this);
    } catch (e) {
      return this;
    }
  }

  num get wd {
    try {
      return ScreenUtil().setWidth(this).toDouble();
    } catch (e) {
      return this;
    }
  }

  ///[ScreenUtil.setHeight]
  num get h {
    try {
      return ScreenUtil().setHeight(this);
    } catch (e) {
      return this;
    }
  }

  ///[ScreenUtil.setSp]
  num get sp {
    try {
      return ScreenUtil().setSp(this);
    } catch (e) {
      return this;
    }
  }

  ///[ScreenUtil.setSp]
  num get ssp {
    try {
      return ScreenUtil().setSp(this, allowFontScalingSelf: true);
    } catch (e) {
      return this;
    }
  }

  ///[ScreenUtil.setSp]
  num get nsp {
    try {
      return ScreenUtil().setSp(this, allowFontScalingSelf: false);
    } catch (e) {
      return this;
    }
  }
}

extension StringExt on String {
  bool isNullOrBlank() => (this == null || this.trim().length <= 0);

  bool isNullOrEmpty() => (this == null || this.length <= 0);

  String blankToNull() => this.isNullOrBlank() ? null : this;
}

extension NullExt on Null {
  bool isNullOrBlank() => true;
}

extension ListExt on List {
  bool isNullOrEmpty() => (this == null || this.isEmpty);

  List empty2Null() => this.isNullOrEmpty() ? null : this;
}

extension IntExt on int {
  DateCountDown toCountDown({DateCountDown countDown}) {
    if (countDown == null) countDown = DateCountDown();
    if (this <= 0) return countDown;

    countDown.countDownTime = this;
    countDown.s = this ~/ 1000 % 60;
    countDown.m = this ~/ 1000 ~/ 60 % 60;
    countDown.h = this ~/ 1000 ~/ 60 ~/ 60 % 100;
    countDown.s_ten = countDown.s ~/ 10;
    countDown.s_bits = countDown.s % 10;
    countDown.m_ten = countDown.m ~/ 10;
    countDown.m_bits = countDown.m % 10;
    countDown.h_ten = countDown.h ~/ 10;
    countDown.h_bits = countDown.h % 10;
    return countDown;
  }
}

class DateCountDown {
  int countDownTime = 0;
  int s = 0;
  int m = 0;
  int h = 0;
  int s_ten = 0;
  int s_bits = 0;
  int m_ten = 0;
  int m_bits = 0;
  int h_ten = 0;
  int h_bits = 0;

  String zs() => s < 10 ? "0$s" : "$s";

  String zm() => m < 10 ? "0$m" : "$m";

  String zh() => h < 10 ? "0$h" : "$h";

  DateCountDown tick() {
    return (countDownTime - 1000).toCountDown(countDown: this);
  }

  @override
  String toString() {
    return 'DateCountDown{countDownTime: $countDownTime, s: $s, m: $m, h: $h, s_ten: $s_ten, s_bits: $s_bits, m_ten: $m_ten, m_bits: $m_bits, h_ten: $h_ten, h_bits: $h_bits}';
  }
}

///简易异常捕获
extension TryExt on Function {
  void tryPrint() {
    try {
      this();
    } catch (e) {
      logger.e(e);
    }
  }
}

extension MapExt on Map {
  Map p(String key, dynamic value) {
    if (!key.isNullOrBlank() && value != null) {
      if (value is String && value.isNullOrBlank()) {
        return this;
      } else {
        this[key] = value;
      }
    }
    return this;
  }
}
