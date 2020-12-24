
import 'package:half_body_fox/util/toast_util.dart';

import 'error_code_manager.dart';

class ExceptionHandle {
  ///约定异常
  static String codeError(code, {bool showToast,String serverMessage}) {
    switch (code) {
      default:
        return toast("code : $code System busy，try again", showToast: showToast);
    }
  }

  static String toast(String text, {bool showToast = true}) {
    if (showToast) ToastUtil.showT(text);
    
    return text;
  }
}
