import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:half_body_fox/util/event_util.dart';
import 'package:half_body_fox/util/internationalization.dart';
import 'package:half_body_fox/util/logger_util.dart';
import 'package:half_body_fox/util/sp_util.dart';
import 'package:half_body_fox/views/home/Home.dart';
import 'package:half_body_fox/widget/future_loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'base/info_util.dart';
import 'base/routes.dart';
import 'exception/code_exception.dart';
import 'ext/config_ext.dart';
import 'network/http.dart';

void main() {
  initConfigs();
  runApp(AppLauncher());
}

class AppLauncher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LocaleUtil.init(context);
    return MaterialApp(
      color: Colors.white,
      ///配置路由表/页面跳转成功后附带的参数
      routes: Routes.routePath,
      home: Home(),
    );
  }
}

///统一异常处理
buildErrorWidget(FlutterErrorDetails flutterErrorDetails) {
  print(flutterErrorDetails.toString());
  var showMsg = "";

  var exception = flutterErrorDetails.exception;
  if (exception is CodeException) {
    showMsg = "${exception.code}:${exception.msg}";
  } else {
    showMsg = "$exception";
  }
  return Center(
    child: Text(showMsg),
  );
}

///sp、用户对象、dio、eventBus配置初始化
initConfigs() async {
  logger = LoggerManager();
  initGlobalExceptionsCatcher();
  InfoUtils.init();
  EventUtil.init();
  ///锁定竖屏 android 经测试有效 （据说ios无效）
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await initSP();
  await HttpUtil.initDio();
}

Future<void> initSP() async {
  try {
    SharedPreferences sp = await SharedPreferences.getInstance();
  } catch (e) {
    if (isDebug()) SharedPreferences.setMockInitialValues({});
    logger.e(e);
  }

  SharedPreferences sp = await SharedPreferences.getInstance();
  SPUtil.setSP(sp);
}

void initGlobalExceptionsCatcher() {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) async {
    // 转发至 Zone 的错误回调
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) => isDebug() ? buildErrorWidget(flutterErrorDetails) : ErrorView();
}

