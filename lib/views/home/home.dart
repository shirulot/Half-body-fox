import 'package:flutter/material.dart';
import 'package:half_body_fox/base/base_state.dart';
import 'package:half_body_fox/base/base_stateless_widget.dart';
import 'package:half_body_fox/base/list_state.dart';
import 'package:half_body_fox/base/routes.dart';
import 'package:half_body_fox/entity/home_entity.dart';
import 'package:half_body_fox/resource/color_resource.dart';
import 'package:half_body_fox/ext/ext.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:half_body_fox/views/animation/animation_demo.dart';
import 'package:half_body_fox/views/home/child/item_home.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends ListState<Home> {
  @override
  title() => "home";

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(360, 640));
    return super.build(context);
    // return Container(
    //   color: Colors.white,
    //   height: double.infinity,
    //   width: double.infinity,
    //   child: Container(height: 50.w, width: 50.w, color: color_mainBlue).intoCenter(),
    // );
  }

  @override
  Widget buildItem(BuildContext context, int index) {
    return ItemHome(item: list[index], position: index);
  }

  @override
  Future<List> loadData2Model(int pageOrFromCount) async {
    return [
      HomeEntity(icon: Icon(Icons.animation, size: 20.w), title: "animation", onClick: () => Navigator.of(context).pushNamed(route_animation)),
      HomeEntity(
          icon: Icon(Icons.switch_left, size: 20.w),
          title: "animated switcher",
          onClick: () => Navigator.of(context).pushNamed(route_animated_switcher)),
    ];
  }
}
