import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:half_body_fox/exception/code_exception.dart';
import 'package:half_body_fox/network/url_path_resource.dart';
import 'package:half_body_fox/util/logger_util.dart';
import 'package:half_body_fox/util/toast_util.dart';
import 'package:path_provider/path_provider.dart';

import 'cookies.dart';
import 'exception_handle.dart';

class HttpUtil {
  static Dio dio;

  static Map<String, dynamic> mHeaders = Map();

  // T extends BaseData
  static Future requestNetwork<T>(String path, {dynamic request, Function onSend, bool showToast = true, bool sourceData = false}) async {
    initDio(); //可能为不存在
    try {
      getHeader();

      ///删除null 避免发出null字符串 需要传null的话先toString
      if (request != null && request is Map && request.isNotEmpty) {
        request.removeWhere((key, value) => value == null);
        logger.i("request :\nheaders = ${dio.options.headers}\n path :$path\n param: $request");
      } else if (request != null && request is FormData) {
        request.fields.removeWhere((element) => false);
        logger.i("request : path :$path param: ${request.fields}");
        logger.i("request : path :$path param: ${request.files}");
      }

      Response response = await dio.post(path, data: request, onSendProgress: onSend);

      ///如果获取源数据 直接返回
      if (sourceData) return response;
      if (response.statusCode == 200) {
        var data = response.data;
        var code = data["code"].toInt();
//        catcher?.update(code);
        if (code == 0) {
          String res2Json = json.encode(data);
          Map<String, dynamic> map = json.decode(res2Json);
          logger.i("response data = $data");
          return Future.value(map["data"]);
        } else {
          logger.e("path = $path,"
              "\nrequest = $request,"
              "\ncode = $code,"
              "\nserver msg = ${data["msg"]},"
              "\nstatusCode = ${response.statusCode},"
              "\nstatusMsg = ${response.statusMessage}");
          return Future.error(CodeException(
              code: code, msg: ExceptionHandle.codeError(code, serverMessage: data["msg"], showToast: showToast), serverMessage: data["msg"]));
        }
      } else {
        return Future.error(
          CodeException(
            code: response.statusCode,
            msg: ExceptionHandle.codeError(response.statusCode, showToast: showToast),
            serverMessage: response.statusMessage,
          ),
        );
      }
    } catch (exception) {
      if (exception is DioError) {
        formatError(exception);
      }
      toast("System busy,try agian.", showToast: showToast);
      logger.e("HttpUtil 70 e = ", exception);
      throw exception;
    }
  }

  static CookieJarImpl cookieJar;
  static var catchPath;

  static void initDio() async {
    if (dio == null) {
      var options = BaseOptions(
          baseUrl: host,
          contentType: "application/x-www-form-urlencoded",
          connectTimeout: 30 * 1000,
          sendTimeout: 30 * 1000,
          receiveTimeout: 30 * 1000);
      dio = new Dio(options);
      catchPath = await getTemporaryDirectory();
      cookieJar = CookieJarImpl();
      dio.interceptors.add(CookieManager(cookieJar));
    }
  }

  cookieClear() {
    cookieJar.clear();
  }

  /// http 错误码
  static String formatError(DioError e) {
    switch (e.type) {
      case DioErrorType.CONNECT_TIMEOUT:
      case DioErrorType.SEND_TIMEOUT:
      case DioErrorType.RECEIVE_TIMEOUT:
        toast("connect time out");
        break;
      case DioErrorType.CANCEL:
        break;
      case DioErrorType.RESPONSE:
      case DioErrorType.DEFAULT:
        toast("System busy，try again");
        break;
    }
  }

  static String toast(String text, {bool showToast = true}) {
    if (showToast) ToastUtil.showT(text);
    return text;
  }

  static void getHeader() {
    // mHeaders["user_id"] = User.getUserIdCanNull();
    dio.options.headers.addAll(mHeaders);
  }
}
