import 'package:flutter/material.dart';
import 'package:half_body_fox/resource/color_resource.dart';
import 'package:half_body_fox/util/ui_tools.dart';
import 'package:half_body_fox/ext/ext.dart';
import 'package:half_body_fox/widget/net_img.dart';

class UserIcon extends StatelessWidget {
  double sizeRatio = 64.0 / 54.0;
  double fullWidth;
  double iconWidth;
  int vipLevel;
  String iconUrl;
  String vipUrl;
  bool whiteIcon;

  UserIcon({
    this.fullWidth,
    this.iconWidth,
    this.iconUrl = "",
    this.vipUrl,
    this.vipLevel = 0,
    this.whiteIcon = false,
  }) {
    if (fullWidth == null && iconWidth != null) fullWidth = iconWidth * sizeRatio;
    if (fullWidth != null && iconWidth == null) iconWidth = fullWidth / sizeRatio;
  }

  @override
  Widget build(BuildContext context) {
    if (whiteIcon) {
      return Container(
        width: fullWidth,
        height: fullWidth,
        child: Container(
          width: iconWidth,
          height: iconWidth,
          decoration: getCornersDecoration(
            bgColor: color_white,
            circular: iconWidth,
          ),
        ),
      );
    } else {
      return (iconWidth == null && fullWidth == null)
          ? Container()
          : Container(
              width: fullWidth,
              height: fullWidth,
              child: Stack(
                children: [
                  ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(iconWidth)),
                          child: NetImage(width: iconWidth, height: iconWidth, url: iconUrl, defPath: "images/ic_pic.webp",errorPath:  "images/ic_pic.webp",))
                      .intoCenter(),
                  (vipUrl == null
                          ? _defaultVipIcon()
                          : NetImage(
                              width: fullWidth,
                              height: fullWidth,
                              url: iconUrl,
                              defPath: "images/ic_pic.webp",
                              errorPath: "images/ic_pic.webp",
                            ))
                      .intoAlign(Alignment.center),
                ],
              ),
            );
    }
  }

  Widget _defaultVipIcon() {
    if (vipLevel == 0) {
      return Container();
    }
    return Image.asset(
      "images/ic_frame_vip$vipLevel.webp",
      height: fullWidth,
      width: fullWidth,
    );
  }
}
