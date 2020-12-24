import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:half_body_fox/util/ui_tools.dart';
import 'package:half_body_fox/ext/ext.dart';

// ignore: must_be_immutable
class NumberIndicator extends StatefulWidget {
  bool hasBigIcon;
  int count;
  int selection;

  NumberIndicator({Key key, this.hasBigIcon = false, this.count, this.selection}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NumberIndicatorState();
}

class NumberIndicatorState extends State<NumberIndicator> {
  Color bgColor = const Color(0x4D000000);
  final double tagBigIconHeight = 46.w;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36.w,
      height: 18.w,
      margin: EdgeInsets.only(
        bottom: (14.w + (widget.hasBigIcon && widget.selection == 0 ? tagBigIconHeight : 0)).toDouble(),
        right: 14.w,
      ),
      child: Stack(
        children: <Widget>[
          Container(
            width: 36.w,
            height: 18.w,
            decoration: getCornersDecoration(
              bgColor: bgColor,
              circular: 8.w,
            ),
          ),
          Text(
            "${widget.selection + 1}/${widget.count}",
//          "select/count",
            style: TextStyle(fontSize: 11.w, color: Colors.white),
            textScaleFactor: 1,
            textAlign: TextAlign.center,
          ).intoAlign(Alignment.center)
        ],
      ),
    );
  }

  notify(int selection, int count) {
    setState(() {
      widget.selection = selection;
      widget.count = count;
    });
  }
}
