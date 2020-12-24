import 'package:flutter/material.dart';
import 'package:half_body_fox/views/animation/animated_switcher_counter_route.dart';
import 'package:half_body_fox/views/animation/animation_demo.dart';

const route_animation = "/animation";
const route_animated_switcher = "/animation/switcher";

class Routes {

  static Map<String, WidgetBuilder> routePath = {
    route_animation: (context, {arguments}) => AnimationDemo(),
    route_animated_switcher: (context, {arguments}) => AnimatedSwitcherCounterRoute(),
  };
}
