import 'package:flutter/material.dart';

class HomeEntity {
  HomeEntity({@required this.title, @required this.icon,@required this.onClick});

  String title;
  Widget icon;
  Function onClick;
}
