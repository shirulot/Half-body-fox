import 'package:flutter/material.dart';

/// 背景 前景
class BGView extends CustomPainter {
  Paint _paint;

  Color bgColor;
  Color eventStartColor;
  Color eventEndColor;

  Path _bgPath;
  Path _linePath;

  Rect _rect;

  /// 贝塞尔反切背景 弧线高度
  var lineWidth = 8.0;

  /// 贝塞尔反切背景 屏外宽度倍率
  /// 0 - 曲线高度*该倍率 = 屏幕外的曲线起始点
  /// 宽度 + 曲线高度*该倍率 = 屏幕外的曲线终点
  var lineMigrationRate = 1.9;

  ///渐变
  Gradient linearGradient;

  var isEvent = false;

  BGView(
      {Key key,
      this.isEvent = false,
      this.bgColor = Colors.white,
      this.eventStartColor = const Color(0xFFFFB325),
      this.eventEndColor = const Color(0xFFFF9153)}) {
    _paint = Paint();
    _bgPath = Path();
    _linePath = Path();
    linearGradient = LinearGradient(
        begin: Alignment.topLeft, end: Alignment.bottomRight, tileMode: TileMode.mirror, colors: <Color>[eventStartColor, eventEndColor]);
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (_rect == null) _rect = Rect.fromLTRB(0, 0, size.width, size.height);
    if (isEvent) {
      drawReversCutBG(canvas, size);
      drawReversCutLine(canvas);
    } else {
      drawReversCutBG(canvas, size);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  void drawReversCutBG(Canvas canvas, Size size) {
    _paint.style = PaintingStyle.fill;
    _paint.color = bgColor;
    _bgPath.reset();
    _bgPath.quadraticBezierTo(_rect.right / 2.0, _rect.bottom * 2.0, _rect.right, 0.0);
    _bgPath.lineTo(_rect.right, _rect.bottom);
    _bgPath.lineTo(_rect.left, _rect.bottom);
    _bgPath.close();
    canvas.drawPath(_bgPath, _paint);
  }

  void drawReversCutLine(Canvas canvas) {
    _linePath.reset();

    var shader = linearGradient.createShader(_rect);
    _paint.shader = shader;
    _paint.strokeWidth = lineWidth;
    _paint.style = PaintingStyle.stroke;
    _linePath.moveTo(-lineWidth * lineMigrationRate, 0);
    _linePath.quadraticBezierTo(
        _rect.right / 2, (_rect.bottom) * 2 - lineWidth * (lineMigrationRate - 1), _rect.right + lineWidth * lineMigrationRate, 0);
    canvas?.drawPath(_linePath, _paint);
  }
}
