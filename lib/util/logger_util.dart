import 'package:logger/logger.dart';
import 'package:half_body_fox/ext/config_ext.dart';

LoggerManager logger;

///避免大幅度修改
class LoggerManager {
   Logger _log;

  LoggerManager() {
    _log = Logger();
  }

  d(dynamic message, [dynamic error, StackTrace stackTrace]) {
    if (isDebug()) _log.d(message);
  }

  i(dynamic message, [dynamic error, StackTrace stackTrace]) {
    if (isDebug()) _log.i(message);
  }

  e(dynamic message, [dynamic error, StackTrace stackTrace]) {
    if (isDebug()) _log.e(message);
  }

  w(dynamic message, [dynamic error, StackTrace stackTrace]) {
    if (isDebug()) _log.w(message);
  }

  v(dynamic message, [dynamic error, StackTrace stackTrace]) {
    if (isDebug()) _log.v(message);
  }

  wtf(dynamic message, [dynamic error, StackTrace stackTrace]) {
    if (isDebug()) _log.wtf(message);
  }
}
