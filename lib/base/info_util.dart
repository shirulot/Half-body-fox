import 'dart:convert';
import 'dart:io';

import 'package:half_body_fox/util/logger_util.dart';
import 'package:package_info/package_info.dart';
import 'package:device_info/device_info.dart';
import 'package:half_body_fox/ext/ext.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class InfoUtils {
  ///当取不到code时取值 根据本人手动更新 因为可能忘记 所以不原则上不应该直接使用
  static final int versionCode = 1;
  static String appName;
  static String packageName;
  static String version;
  static String buildNumber;
  static IosDeviceInfo iosInfo;
  static AndroidDeviceInfo androidInfo;
  static String deviceId;

  static init() async {
    try {
      getVersionInfo();
      await getDeviceInfo();
    } catch (e) {
      logger.e(e);
    }
  }

  static getVersionInfo() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;

      return buildNumber;
    });
  }

  static int getVersionCode() {
    try {
      return int.parse(buildNumber);
    } catch (e) {
      return versionCode;
    }
  }

  static String getPlatform() {
    if (Platform.isIOS) {
      return "ios";
    } else if (Platform.isAndroid) {
      return "android";
    } else {
      return Platform.operatingSystem;
    }
  }

  static int getOrderSource() {
    if (Platform.isIOS) {
      return 3;
    } else {
      return 2;
    }
  }

  static int getADPlatformType() {
    if (Platform.isIOS) {
      return 2;
    } else {
      return 1;
    }
  }

  ///获取唯一标识一定要使用该方法
  static String getDeviceId() {
    if (Platform.isIOS) {
      return iosInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      ///TODO 存在缺陷获取为空可能 之后移入openUUID
      return androidInfo.display;
    } else {
      return "";
    }
  }

  static String infoKey = "GetU:Equipment Label";

  static void getDeviceInfo() async {
    try{
      DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
      // Create storage
      final storage = FlutterSecureStorage();
      // Read value
      deviceId = await storage.read(key: infoKey);

      if (Platform.isIOS) {
        iosInfo = await deviceInfo.iosInfo;
        if (deviceId.isNullOrBlank()) {
          deviceId = iosInfo.identifierForVendor;
          storage.write(key: infoKey, value: iosInfo.identifierForVendor);
        }
        logger.d('IOS'
            "\nmodel = ${iosInfo.model}"
            "\nname = ${iosInfo.name}"
            "\nsystemName = ${iosInfo.systemName}"
            "\nlocalizedModel = ${iosInfo.localizedModel}"
            "\nidentifierForVendor = ${iosInfo.identifierForVendor}"
            "\ndeviceId = $deviceId"
            "\nisPhysicalDevice = ${iosInfo.isPhysicalDevice}"
            "\nmachine = ${iosInfo.utsname.machine}"
            "\nodename = ${iosInfo.utsname.nodename}");
      } else if (Platform.isAndroid) {
        logger.d('Android');
        androidInfo = await deviceInfo.androidInfo;
        logger.d("android info = ${androidInfo}");
//      androidInfo.id
      }
    }catch(e){
      logger.e(e);
    }
  }
}
