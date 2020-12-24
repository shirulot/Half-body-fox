import 'package:flutter/material.dart';
import 'package:half_body_fox/entity/home_entity.dart';
import 'package:half_body_fox/resource/color_resource.dart';
import 'package:half_body_fox/ext/ext.dart';

class ItemHome extends StatelessWidget {
  HomeEntity item;
  int position;

  ItemHome({Key key, @required this.item, this.position}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.w,
      width: double.infinity,
      padding: EdgeInsets.only(left: 10.w),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // item.icon,
              Hero(
                tag: "anim$position",
                child: item.icon.clipOval(tr: 99, tl: 99, bl: 99, br: 99),
              ),
              item.title.intoText(textSize: 20.w, textColor: color_mainBlack).intoPadding(EdgeInsets.only(left: 15.w)),
            ],
          ).intoExpanded(flex: 1),
          Container(
            height: 1.w,
            color: color_grayDD,
            width: double.infinity,
          )
        ],
      ),
    ).setClickListener(() => item.onClick?.call());
  }
}
