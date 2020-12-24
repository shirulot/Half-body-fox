import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///生命周期扩展类  引用至 https://stackoverflow.com/questions/49869873/flutter-update-widgets-on-resume
class LifecycleEventHandler extends WidgetsBindingObserver {
  final Function resumeCallBack;
  final Function pausedCallBack;
  final AsyncCallback inactiveCallBack;
  final AsyncCallback detachedCallBack;

  LifecycleEventHandler({
    this.resumeCallBack,
    this.pausedCallBack,
    this.inactiveCallBack,
    this.detachedCallBack,
  });

//  int lastTime = 0;

  @override
  Future<Null> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      //重新打开
      case AppLifecycleState.resumed:

        if (resumeCallBack != null) {
          await resumeCallBack();
        }
        break;
      case AppLifecycleState.paused: //退到后台
        if (pausedCallBack != null) {
          await pausedCallBack();
        }
        break;

      case AppLifecycleState.inactive: //不活跃的
        if (inactiveCallBack != null) {
          await inactiveCallBack();
        }
        break;

      case AppLifecycleState.detached: //组件被回收
        if (detachedCallBack != null) {
          await detachedCallBack();
        }
        break;
    }
  }
}
