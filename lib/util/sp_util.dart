import 'package:shared_preferences/shared_preferences.dart';

class SPUtil {

  static SharedPreferences _sp;

  static SharedPreferences getInstance() {
    return _sp;
  }
  ///避免面次都写await/then sp直接
  static setSP(SharedPreferences sp) {
    SPUtil._sp = sp;
  }
}
