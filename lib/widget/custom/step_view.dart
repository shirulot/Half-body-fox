import 'package:flutter/material.dart';
import 'package:half_body_fox/resource/color_resource.dart';
import 'package:half_body_fox/resource/string_resource.dart';
import 'package:half_body_fox/ext/ext.dart';

class StepView extends CustomPainter {
  Paint _paint;

  int max;

  int _step;

  double textSize;

  double passStrokeWidth;
  double lineWidth;
  double textTopMargin;
  double pointWidth;

  Color passTextColor;
  Color activeTextColor;
  Color negativeTextColor;

  Color passStrokeColor;
  Color activeColor;
  Color negativeColor;

  double horizontalMargin;

  StepView({
    this.max = 5,
    int step = 1,
    this.textSize,
    this.textTopMargin,
    this.passStrokeWidth,
    this.lineWidth,
    this.horizontalMargin,
    this.passTextColor = color_mainBlack,
    this.activeTextColor = color_mainRed,
    this.negativeTextColor = color_grayE7,
    this.passStrokeColor = color_mainRed,
    this.activeColor = color_mainRed,
    this.negativeColor = color_grayE7,
  }) {
    _step = step - 1;
    textSize = textSize ?? 13.w;
    textTopMargin = textTopMargin ?? 8.w;
    passStrokeWidth = passStrokeWidth ?? 1.5.w;
    lineWidth = lineWidth ?? 1.w;
    horizontalMargin = horizontalMargin ?? 25.w;
    pointWidth = pointWidth ?? 12.w;
    _paint = Paint();
  }

  int getStep() {
    return _step + 1;
  }

  var listMax5 = [text_apply, text_processing, text_confirm, text_return, text_refund];
  var listMax4 = [text_apply, text_processing, text_confirm, text_refund];
  var _lineWidth;

  @override
  void paint(Canvas canvas, Size size) {
    ///除去上方圆部分的左右间距 上方圆+线段的总宽
    var progressWidth = size.width - horizontalMargin * 2;

    ///单条线的长度
    _lineWidth = (progressWidth - max * pointWidth) / (max - 1);
    for (int i = 0; i < max; i++) {
      var circleCenterX = i * (pointWidth + _lineWidth) + pointWidth / 2 + horizontalMargin;
      drawCircle(canvas, circleCenterX, i);
      drawLine(canvas, circleCenterX, i);
      drawText(canvas, circleCenterX, i);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  ///绘制圆
  void drawCircle(Canvas canvas, double circleCenterX, int index) {
    _paint.style = index < _step ? PaintingStyle.stroke : PaintingStyle.fill;
    _paint.color = index == _step ? activeColor : (index < _step ? passStrokeColor : negativeColor);
    canvas.drawCircle(Offset(circleCenterX, pointWidth / 2), pointWidth / 2, _paint);
  }

  ///绘制圆左边的线段
  void drawLine(Canvas canvas, double circleCenterX, int index) {
    if (index != 0) {
      _paint.color = index <= _step ? activeColor : negativeColor;
      var lineEndX = circleCenterX - pointWidth / 2;
      var lineStartX = lineEndX - _lineWidth;
      canvas.drawLine(Offset(lineStartX, pointWidth / 2), Offset(lineEndX, pointWidth / 2), _paint);
    }
  }

  ///绘制文本
  void drawText(Canvas canvas, double circleCenterX, int index) {
    TextPainter textPainter = buildTextPainter(index);
    textPainter.layout();
    var textLeftX = circleCenterX - textPainter.width / 2;
    var textTopY = pointWidth + textTopMargin;
    textPainter.paint(canvas, Offset(textLeftX, textTopY));
  }

  ///创建文本paint
  TextPainter buildTextPainter(int index) {
    return TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: max == 4 ? listMax4[index] : listMax5[index],
        style: TextStyle(
          fontSize: textSize,
          color: index == _step ? activeTextColor : (index < _step ? passTextColor : negativeTextColor),
        ),
      ),
    );
  }
}
