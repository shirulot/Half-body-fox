import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/foundation.dart';
import 'package:half_body_fox/resource/key_resource.dart';
import 'package:half_body_fox/util/logger_util.dart';
import 'package:half_body_fox/util/sp_util.dart';
class CookieJarImpl implements CookieJar {
  var _map = HashMap<String, List<Cookie>>();

  List<Cookie> cookiesList = List();

  @override
  List<Cookie> loadForRequest(Uri uri) {
    // logger.e("request map = ${_map}");
    if (_map == null || _map[uri.host] == null || _map[uri.host].isEmpty) {
      var sp = SPUtil.getInstance();
      String cookieJson = sp.getString(KEY_COOKIE);
      cookiesList.clear();
      if (cookieJson == null || cookieJson.isEmpty) {
        return cookiesList;
      } else {
        print(cookieJson);
        SerializableCookie cookie = SerializableCookie.fromJson(cookieJson);
        cookiesList.add(cookie.cookie);
        return cookiesList;
      }
    } else {
      return _getMapFirstCookie(_map[uri.host]);
    }
  }

  //做单个cookies判断
  @override
  void saveFromResponse(Uri uri, List<Cookie> cookies) {
    //  1. 刷新内存中cookie
    List<Cookie> pop = _map[uri.host];
    _map[uri.host] = cookies;
    // logger.i("cookies = ${cookies[0].toString()}");

    /// 如果和内存中的cookie相同
    if (pop != null && pop.isNotEmpty && cookies[0].value == pop[0].value) {
      // logger.i("cookies 和上次相同 = $cookies");
    } else {
      /// 如果不相同，那么更新硬盘中的cookie
      logger.w("cookie update :\noldJson = ${cookies.toString()}\nnewJson = ${cookies.toString()} ");
      //TODO 写sp操作过于频繁 考虑优化
      saveToSP(cookies);
    }
  }

  saveToSP(List<Cookie> cookies) {
    try {
      var serializableCookie = SerializableCookie(cookies[0]);
      String cookieJson = serializableCookie.toJson();
      SPUtil.getInstance().setString(KEY_COOKIE, cookieJson);
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  bool get ignoreExpires => false;

  var tempCookieList = List<Cookie>();

  List<Cookie> _getMapFirstCookie(List<Cookie> cookie) {
    tempCookieList.clear();
    if (cookie.length > 0) {
      tempCookieList.add(cookie[0]);
    }
    return tempCookieList;
  }

  clear() {
    _map.clear();
    SPUtil.getInstance().remove(KEY_COOKIE);
  }
//
//  String toJson(List<Cookie> cookies) {
//    for (var value in cookies) {
//        value.
//    }
//  }
}
