import 'dart:ui';

import 'package:half_body_fox/ext/ext.dart';
import 'ext_base_button.dart';
import 'ext_button.dart';
import 'ext_button_data.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class GroupExtButton extends StatefulWidget {
  ///旋转角度
  double finalAngle;

  ///基础按钮宽度
  double baseButtonWidth;

  /// 组件最大占用宽度
  double maxWidth;

  /// 移动动画所占的时间权重比
  double moveWeight;

  /// 扩展按钮动画所占的时间权重比
  double extOnWeight;

  /// 子布局透明度动画所占的时间权重比
  double childAlpWeight;

  ///动画持续时间
  Duration duration;

  /// 扩展按钮UI数据
  List<ExtButtonData> extButtonList;

  Color baseButtonBeginBGColor;
  Color baseButtonEndBGColor;

  Color baseButtonBeginPlusColor;
  Color baseButtonEndPlusColor;

  ///扩展按钮高度
  double extButtonHeight;

  //扩展按钮间距
  double extButtonBottomMargin;

  GroupExtButton({
    @required this.maxWidth,
    @required this.baseButtonWidth,
    @required this.extButtonHeight,
    @required this.extButtonBottomMargin,
    this.finalAngle = 225,
    this.moveWeight = 0.3,
    this.extOnWeight = 0.3,
    this.childAlpWeight = 0.4,
    this.duration = const Duration(milliseconds: 800),
    this.extButtonList = const [],
    this.baseButtonBeginBGColor = const Color(0xFFEA2112),
    this.baseButtonEndBGColor = const Color(0xFFEEEEEE),
    this.baseButtonBeginPlusColor = Colors.white,
    this.baseButtonEndPlusColor = const Color(0xFFCCCCCC),
  }) {
    baseButtonWidth = baseButtonWidth ?? 54.w;
    maxWidth = maxWidth ?? 135.w;
    extButtonHeight = extButtonHeight ?? 45.w;
    extButtonBottomMargin = extButtonBottomMargin ?? 20.w;
  }

  @override
  State<StatefulWidget> createState() => GroupExtButtonState();
}

class GroupExtButtonState extends State<GroupExtButton> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Animation<Color> animationPlusColor;
  Animation<Color> animationBGColor;
  double _start = 0;
  double _end = 1;

  double extButtonHeight;
  double extButtonBottomMargin;

  double maxWidth;
  double moveWeight;
  double extOnWeight;

  Duration duration;
  double childAlpWeight;
  double finalAngle;
  double baseButtonWidth;

  Color baseButtonBeginBGColor;
  Color baseButtonEndBGColor;
  Color baseButtonBeginPlusColor;
  Color baseButtonEndPlusColor;

  List<ExtButtonData> extButtonList;

  @override
  void initState() {
    extButtonHeight = widget.extButtonHeight;
    extButtonBottomMargin = widget.extButtonBottomMargin;
    baseButtonBeginBGColor = widget.baseButtonBeginBGColor;
    baseButtonEndBGColor = widget.baseButtonEndBGColor;
    baseButtonBeginPlusColor = widget.baseButtonBeginPlusColor;
    baseButtonEndPlusColor = widget.baseButtonEndPlusColor;
    finalAngle = widget.finalAngle;
    baseButtonWidth = widget.baseButtonWidth;
    maxWidth = widget.maxWidth;
    moveWeight = widget.moveWeight;
    extOnWeight = widget.extOnWeight;
    childAlpWeight = widget.childAlpWeight;
    duration = widget.duration;
    extButtonList = widget.extButtonList;

    controller = AnimationController(vsync: this, duration: duration);
    animationPlusColor = new ColorTween(begin: baseButtonBeginPlusColor, end: baseButtonEndPlusColor).animate(controller);
    animationBGColor = new ColorTween(begin: baseButtonBeginBGColor, end: baseButtonEndBGColor).animate(controller);
    // animationRotation = new Tween(begin: 0.0, end: 0.625).animate(controller);
    animation = new Tween(begin: _start, end: _end).animate(controller)
      ..addListener(() {
        setState(() {
          // print("value = ${animation.value}");
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    extButtonList?.sort();
    List<Widget> viewList = [];
    for (int i = 0; i < extButtonList.length; i++) {
      ExtButtonData item = extButtonList[i];
      viewList.add(ExtButton(
        height: extButtonHeight,
        bottomMargin: extButtonBottomMargin,
        position: i,
        item: item,
        extOnWeight: extOnWeight,
        moveWeight: moveWeight,
        childAlpWeight: childAlpWeight,
        animation: animation,
        extButtonList: extButtonList,
      )
          // .setClickListener(() {
          //   print("position = $i");
          // })

          // .intoAlign(Alignment.bottomRight)
          );
    }

    viewList.add(ExtBaseButton(
      animation: animation,
      start: _start,
      end: _end,
      baseButtonWidth: baseButtonWidth,
      finalAngle: finalAngle,
      animationBGColor: animationBGColor,
      animationPlusColor: animationPlusColor,
      controller: controller,
    ).intoAlign(Alignment.bottomRight));
    return Stack(
      overflow: Overflow.visible,
      children: viewList,
    ).setSize(animation.value == 0 ? baseButtonWidth : maxWidth,
        animation.value == 0 ? baseButtonWidth : baseButtonWidth + extButtonList.length * (extButtonHeight + extButtonBottomMargin));
  }
}
