import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:half_body_fox/base/routes.dart';
import 'package:half_body_fox/resource/color_resource.dart';
import 'package:half_body_fox/util/internationalization.dart';
import 'package:half_body_fox/ext/ext.dart';
import 'base_app_bar.dart';


//弃用
class BaseMain extends StatefulWidget {
  Map arguments;

  BaseMain({Key key});

  @override
  State<StatefulWidget> createState() => BaseMainStateWidget();
}

class BaseMainStateWidget extends State<BaseMain> {
  Map lastData;

  @override
  Widget build(BuildContext context) {
    LocaleUtil.init(context);
    initArgument(context);
    return  Scaffold(
        ///允许控件被遮挡
        resizeToAvoidBottomInset: false,
        appBar: showAppBar(context),
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            body(context),
            _loading(context),
          ],
        ),
    );
  }

  body(BuildContext context) => Container();

  title() => null;

  ///检查appBar是否要展示 title传空时不展示
  showAppBar(BuildContext context) {
    var titleText = title();
    if (titleText != null) {
      return BaseAppBar.build(context,
          title: titleText, rightButtons: rightButtons(context));
    } else {
      return null;
    }
  }

  ///加载中 暂定前几个状态都为进度条
  Widget buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.done:
        // TODO errorView
        if (snapshot.hasError)
          return Center(child: Text('Error: ${snapshot.error}'));
        return futureBody();
      case ConnectionState.none:
      case ConnectionState.active:
      case ConnectionState.waiting:
      default:
        return Center(
          child: CircularProgressIndicator(),
        );
    }
  }

  Widget futureBody() {}

  List<Widget> rightButtons(BuildContext context) => null;

  void initArgument(BuildContext context) {
    var settings;
    try {
      settings = ModalRoute.of(context).settings;
    } catch (e) {
      print(e.toString());
    }
    if (settings != null) {
      lastData = settings.arguments;
    }
  }

  Widget getEmptyPager(int page) {
    return Center(
      child: Text("数据为空"),
    );
  }

  HashMap<String, dynamic> newRequest() {
    return HashMap<String, dynamic>();
  }

  Widget _loading(BuildContext context) {
    if (!defaultLoading()) return Container();
    return Container(
      color: color_dialogTransparent,
      alignment: Alignment.center,
      child: Container(
        width: 40,
        height: 40,
        padding: EdgeInsets.all(5),
        color: Colors.white,
        child: SizedBox.fromSize(
          child: CircularProgressIndicator(
            strokeWidth: 4,
          ),
          size: Size(20, 20),
        ),
      ),
    );
  }

  bool defaultLoading() => false;

  codeError(int code) {
    if (code != null && code != 0) {
      ///TODO 处理协定异常码
    }
  }

  page() {}
}
