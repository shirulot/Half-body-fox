import 'package:flutter/material.dart';
import 'ext_button_data.dart';
import 'package:half_body_fox/ext/ext.dart';

class ExtButton extends StatelessWidget {
  int position;
  ExtButtonData item;
  double extOnWeight;
  double moveWeight;
  double childAlpWeight;
  double height;
  double bottomMargin;
  Animation<double> animation;
  List<ExtButtonData> extButtonList;

  ExtButton({
    this.position,
    this.item,
    this.height,
    this.bottomMargin,
    this.extOnWeight,
    this.moveWeight,
    this.childAlpWeight,
    this.animation,
    this.extButtonList,
  });

  @override
  Widget build(BuildContext context) {
    double alp = 0;
    if (animation.value > extOnWeight + moveWeight) {
      alp = ((animation.value - extOnWeight - moveWeight) / childAlpWeight).limit(min: 0, max: 1).toDouble();
    }
    return Positioned(
      bottom: getExtButtonY(position, item).abs(),
      right: 0,
      child: Container(
        alignment: Alignment.centerRight,
        decoration: getCornersDecoration(bgColor: item.color, circular: height),
        width: getExtWidth(position, item),
        height: height,
        child: item.child?.intoAlp(alp),
      ).setClickListener(() {
        item.onClick?.call(position);
      }).isShow(animation.value != 0),
    );
  }

  double getExtButtonY(int position, ExtButtonData item) {
    var moveEndP = moveWeight / extButtonList.length * (position + 1);
    var fullY = -(bottomMargin + height) * (position + 1);
    if (animation.value < moveEndP) {
      return animation.value / moveEndP * fullY;
    } else {
      return fullY;
    }
  }

  double getExtWidth(int position, ExtButtonData item) {
    ///向上移动动画结束时所用的百分比
    var moveEndP = moveWeight / extButtonList.length * (position + 1);
    //
    if (animation.value > moveEndP && animation.value < moveEndP + extOnWeight) {
      return (item.fullWidth - height) * ((animation.value - moveEndP) / extOnWeight) + height;
    } else if (moveEndP > animation.value) {
      return height;
    } else {
      return item.fullWidth;
    }
  }
}

BoxDecoration getCornersDecoration(
    {Key key,
    Color bgColor = Colors.transparent,
    Color strokeColor = Colors.transparent,
    double strokeWidth = 1,
    double circular = 0,
    BorderRadius borderRadius}) {
  return BoxDecoration(
      shape: BoxShape.rectangle,
      border: new Border.all(color: strokeColor, width: strokeWidth),
      // 边色与边宽度
      borderRadius: borderRadius == null ? BorderRadius.all(Radius.circular(circular)) : borderRadius,
      color: bgColor);
}
