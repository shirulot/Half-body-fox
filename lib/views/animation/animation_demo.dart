import 'package:flutter/material.dart';
import 'package:half_body_fox/base/base_state.dart';
import 'package:half_body_fox/entity/home_entity.dart';
import 'package:half_body_fox/ext/ext.dart';
import 'package:half_body_fox/resource/color_resource.dart';
import 'package:half_body_fox/views/home/child/item_home.dart';

class AnimationDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AnimationDemoState();
}

class AnimationDemoState extends BaseState<AnimationDemo> {
  @override
  title() => "Animation";

  @override
  Widget body(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        children: [
          "animation".intoText(textColor: color_mainBlue, textSize: 30.w),
          Spacer(),
          Hero(tag: "anim0", child: Icon(Icons.account_circle_outlined, color: color_mainBlue, size: 30.w)),
        ],
      ).intoCenter(),
    );
  }
}
