import 'package:flutter/material.dart';
import 'package:half_body_fox/resource/color_resource.dart';
import 'package:half_body_fox/ext/ext.dart';

class SimpleTabBar {
  static PreferredSizeWidget build(
      {@required List<Widget> mTab,
      @required TabController mTabController,
      TabBarIndicatorSize indicatorSize = TabBarIndicatorSize.label,
      EdgeInsetsGeometry indicatorPadding,
      EdgeInsetsGeometry labelPadding,
      bool isScrollable = true,
      TextStyle selectedTextStyle,
      TextStyle unselectedTextStyle,
      Color selectedColor = color_mainBlack,
      Color unselectedColor = color_mainBlack,
      Color indicatorColor = color_mainRed,
      double indicatorWeight}) {
    return TabBar(
      //设置tabBar 的标签显示内容，一般使用Tab对象,当然也可以是其他的Widget
      tabs: mTab,
      //TabController对象
      controller: mTabController,
      //是否可滚动
      isScrollable: isScrollable,
      //指示器颜色
      indicatorColor: indicatorColor,
      //指示器的高度
      indicatorWeight: indicatorWeight ?? 2.w,
      indicatorPadding: indicatorPadding,
        labelPadding:labelPadding,
      //底部指示器的Padding
//      indicatorPadding: EdgeInsets.all(10),
      //指示器decoration，例如边框、颜色等
      indicator: BoxDecoration(shape: BoxShape.rectangle, border: Border(bottom: BorderSide(color: color_mainRed, width: 2.w))),
      //指示器大小计算方式,label 为以文本为边框计算，tab 为以指示器为边框计算
      indicatorSize: indicatorSize,
      //tab 标签颜色
      labelColor: selectedColor,
      //设置标签样式
      labelStyle: selectedTextStyle ?? TextStyle(fontSize: 15.w, fontWeight: FontWeight.bold),
      //未选中Tab中文字颜色
      unselectedLabelColor: unselectedColor,
      //tab 文字样式
      unselectedLabelStyle: unselectedTextStyle ?? TextStyle(fontSize: 15.w), //未选中Tab中文字style
    );
  }
}
