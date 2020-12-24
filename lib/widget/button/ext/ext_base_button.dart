import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:half_body_fox/ext/ext.dart';

class ExtBaseButton extends StatelessWidget {
  double start;
  double end;
  double baseButtonWidth;
  double finalAngle;
  Animation<double> animation;
  Animation<Color> animationBGColor;
  Animation<Color> animationPlusColor;
  AnimationController controller;

  ExtBaseButton({
    this.animation,
    this.start,
    this.end,
    this.baseButtonWidth,
    this.finalAngle,
    this.animationBGColor,
    this.animationPlusColor,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Transform.rotate(
        angle: animation.value * math.pi * (finalAngle / 180),
        child: Container(
          alignment: Alignment.topRight,
          width: baseButtonWidth,
          height: baseButtonWidth,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: animationBGColor.value,
          ),
          child: Image.asset(
            "images/ic_ext_button_plus.png",
            height: baseButtonWidth / 54 * 21,
            width: baseButtonWidth / 54 * 21,
            color: animationPlusColor.value,
          ).intoCenter(),
        ),
      ).setClickListener(() {
        if (!controller.isAnimating) {
          // _controller.forward();
          if (animation.value == end) {
            controller.reverse();
          } else if (animation.value == start) {
            controller.forward();
          }
        }
      }),
    );
  }
}
