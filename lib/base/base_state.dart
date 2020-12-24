import 'dart:async';

import 'package:flutter/material.dart';
import 'package:half_body_fox/base/base_app_bar.dart';
import 'package:half_body_fox/base/routes.dart';
import 'package:half_body_fox/entity/event/page_finish_event.dart';
import 'package:half_body_fox/exception/code_exception.dart';
import 'package:half_body_fox/ext/lifecyc_ext.dart';
import 'package:half_body_fox/network/error_code_manager.dart';
import 'package:half_body_fox/util/event_util.dart';
import 'package:half_body_fox/util/logger_util.dart';
import 'package:half_body_fox/util/toast_util.dart';
import 'package:half_body_fox/widget/future_loading.dart';
import 'package:half_body_fox/ext/ext.dart';
import 'package:half_body_fox/widget/loading_indicator.dart';

class BaseState<T extends StatefulWidget> extends State<T> {
  Map lastData = {};

  var isVisible = false;

  ///绑定生命周期回调 如果子类重写并且需要生命周期方法 则需要调用super
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(LifecycleEventHandler(resumeCallBack: () => onResume(), pausedCallBack: () => onPause()));
    EventUtil.catchEvent((event) {
      if (event is PageFinishEvent && event.routeNames.contains(ModalRoute.of(context).settings.name)) Navigator.of(context).pop();
    });
  }

  ///将上个页面传输的数据存入lastData 中
  void initArgument(BuildContext context) {
    var settings = ModalRoute.of(context).settings;
    if (settings?.arguments != null) {
      lastData = settings.arguments;
    }
  }

  ///生命周期扩展方法
  ///退到后台/组件不活跃 后 返回前台
  onResume() async {
    isVisible = true;
  }

  ///退到后台/组件不活跃
  onPause() async {
    isVisible = false;
  }

  ///组件回收
  onDetached() async {
    isVisible = false;
  }

  ///不活跃
  onInactive() async {}

  ///flag 避免每次调用setState都重新初始化arguments 导致空值覆盖lastData
  var isFirstOpen = true;

  @override
  Widget build(BuildContext context) {
    initArgument(context);
    if (isFirstOpen) initView();
    isFirstOpen = false;
    return Scaffold(
      backgroundColor: Colors.white,
      drawerEdgeDragWidth: 30.w,
      endDrawer: buildEndDrawer(),
      appBar: showAppBar(context),
      body: Builder(builder: (context) => body(context)),
    );
  }

  ///在body和title创建之前 一般用于获取上个页面传输的数据
  initView() {}

  ///重写body 页面主布局 如果需要
  Widget body(BuildContext context) => Container();

  ///如果需要顶部栏 则重写 返回String类型则为默认风格 返回widget则将title替换为返回组件（右按钮不变 如需要重写整个titleBar 则重写showAppBar 返回类型为AppBar）
  title() => null;

  ///appBar底部tabBar
  tabBar() => null;

  ///检查appBar是否要展示 title传空时不展示
  AppBar showAppBar(BuildContext context) {
    var titleText = title();
    if (titleText != null) {
      return BaseAppBar.build(context, title: titleText, rightButtons: rightButtons(context), tabBar: tabBar());
    } else {
      return null;
    }
  }

  ///titleBar 右侧组件 一般为IconButton TextButton 支持多个
  List<Widget> rightButtons(BuildContext context) => null;

  ///加载中 默认转圈进度条 加载完成默认调用futureBody
  Widget buildFuture(BuildContext context, AsyncSnapshot snapshot) => FutureLoading(
      context: context,
      snapshot: snapshot,
      error: errorView(),
      errorType: errorType(),
      loading: loadingWidget(),
      onSuccess: () => futureBody(),
      onError: (e) => onError(e));
  ///异常View 为空时默认采用ErrorView
  Widget errorView() => null;

  ///加载完成后展示body组件 有网络请求页面需要重写
  Widget futureBody() {
    return Container();
  }

  toLogin() {
    ToastUtil.showT("Please log in");
    // Navigator.pushNamed(context, route_login);
  }

  ///通用加载dialog
  showLoading(BuildContext context, {bool cantCancel = true}) {
    return showDialog(
      barrierColor: Color(0x01000000),
      context: context,
      barrierDismissible: cantCancel,

      ///调试方便所以打开
      builder: (BuildContext context) => Center(
        child: MiniLoadingIndicator(),
      ),
    );
  }

//  dismissDialog(BuildContext context,){
////    ModalRoute.of(context).settings ==null
//  }

  Widget loadingWidget() => Center(child: CircularProgressIndicator());

  Widget buildEndDrawer() => null;

  ErrorType errorType() => ErrorType.DEFAULT;

  onError(e) async {
    logger.w(e);
    if (e != null && e is CodeException) {
      switch (e.code) {
         default:
          Timer(Duration(milliseconds: 100), () async {
            // await Navigator.of(context).pushNamed(route_login);
            // if (User.isLogin()) {
            //   User.logout();
            //   setState(() {});
            // }
          });
          break;
      }
    }
  }
}
