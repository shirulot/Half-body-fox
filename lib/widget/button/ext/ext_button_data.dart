import 'dart:core';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef ExtButtonClick = void Function(int position);

class ExtButtonData implements Comparable<ExtButtonData> {
  ///扩展按钮颜色
  Color color;
  ///扩展按钮展开后的宽度
  double fullWidth;
  ///当前扩展按钮下标 按照下标排序
  int index;
  ///扩展按钮内布局
  Widget child;
  /// 点击事件
  ExtButtonClick onClick;

  ExtButtonData({
    @required this.color,
    @required this.fullWidth,
    @required this.index,
    this.onClick,
    this.child,
  });

  @override
  int compareTo(ExtButtonData other) {
    return index > other.index ? 1 : 0;
  }
}
