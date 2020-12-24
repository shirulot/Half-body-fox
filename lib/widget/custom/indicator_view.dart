import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IndicatorView extends CustomPainter {
  /// 圆角的半径
  double rectRadius = 5;

  /// 选中圆角矩形的宽度
  double perWidth = 0;

  /// 未选中圆点的直径
  double norWidth = 5;

  /// 圆点的总数
  int count = 8;

  /// 当前被选中的下标
  int selection = 1;

  ///每个圆点之间的间距
  double spacing = 7;

  /// 上下内间距
  double padding = 0;

  /// 圆点的半径
  double radius = 0;

  Paint _paint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill;

  IndicatorView(this.count,
      {Key key,
      this.rectRadius = 0,
      this.perWidth = 0,
      this.selection = 1,
      this.spacing = 0,
      this.padding = 0}) {
    if (selection >= count) selection = count - 1;
  }

  @override
  void paint(Canvas canvas, Size size) {
    completionParam(size);
    for (var i = 0; i < count; i++) {
      var curLeft = 0.0;

      if (i < selection) {
        curLeft = (norWidth + spacing) * i + padding;
        canvas.drawCircle(Offset(curLeft + radius, norWidth / 2 + padding),
            norWidth / 2, _paint);
      } else if (i == selection) {
        curLeft = (norWidth + spacing) * i + padding;
        canvas.drawRRect(
            RRect.fromLTRBR(
              curLeft,
              padding,
              curLeft + perWidth,
              norWidth + padding,
              Radius.circular(radius),
            ),
            _paint);
      } else {
        curLeft = (norWidth + spacing) * i + perWidth - norWidth + padding;
        canvas.drawCircle(Offset(curLeft + radius, norWidth / 2 + padding),
            norWidth / 2, _paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void completionParam(Size size) {
    norWidth = size.height - padding * 2;
    if (perWidth == 0) perWidth = norWidth * 2;
    if (spacing == 0) spacing = norWidth * 0.8;
    radius = norWidth / 2;
  }

  static double getWidth(double mHeight, int count,
      {Key key,
      double mPadding = 0,
      double mNorWidth = 0,
      double mPerWidth = 0,
      double mSpacing = 0}) {
    if (mNorWidth == 0) mNorWidth = mHeight - mPadding * 2;
    if (mPerWidth == 0) mPerWidth = mNorWidth * 2;
    if (mSpacing == 0) mSpacing = mNorWidth * 0.8;
    if (count == 1) return mPerWidth + mPadding * 2;
    return (count - 1) * (mNorWidth + mSpacing) + mPerWidth + mPadding * 2;
  }
}
