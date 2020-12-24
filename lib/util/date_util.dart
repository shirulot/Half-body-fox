import 'package:half_body_fox/ext/ext.dart';

class DateUtils {
  /// 计算当前时间是否在某个时间段之间 常用于闪购时间计算
  static bool isBetween(int startTime, int endTime, {int targetTime = -1}) {
    if (targetTime == -1) {
      targetTime = DateTime.now().millisecondsSinceEpoch;
    }
    return startTime < targetTime && endTime > targetTime;
  }

  static DateCountDown getFlashCountDownTime(int startTime, int endTime, {int targetTime = -1, DateCountDown countDown}) {
    var dataIsBetween = isBetween(startTime, endTime, targetTime: targetTime);
    if (targetTime == -1) {
      targetTime = DateTime.now().millisecondsSinceEpoch;
    }
    var diffTime = dataIsBetween ? (endTime - targetTime) : (startTime - targetTime);
    return diffTime.toCountDown(countDown: countDown);
  }
}

var month = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec"];

String formatDate(DateTime dateTime, {int length = 0}) {
  var s = "${dateTime.second < 10 ? "0" : ""}${dateTime.second}";
  var m = "${dateTime.minute < 10 ? "0" : ""}${dateTime.minute}";
  var h = "${dateTime.hour < 10 ? "0" : ""}${dateTime.hour}";
  var dayText = "${dateTime.day < 10 ? "0" : ""}${dateTime.day}";
  var monthText = "${month[dateTime.month - 1]}";
  var yearText = "${dateTime.year < 10 ? "0" : ""}${dateTime.year}";
  length = length > 5 ? 5 : length;

  switch (length) {
    case 0:
      return yearText;
    case 1:
      return "$monthText $yearText";
    case 2:
      return "$dayText $monthText $yearText";
    case 3:
      return "$dayText $monthText $yearText $h";
    case 4:
      return "$dayText $monthText $yearText $h:$m";
    case 5:
    default:
      return "$dayText $monthText $yearText $h:$m:$s";
  }
}

DateCountDown getCountDownTime(int startTime, int endTime, {int targetTime = -1, DateCountDown countDown}) {
  var dataIsBetween = DateUtils.isBetween(startTime, endTime, targetTime: targetTime);
  if (targetTime == -1) {
    targetTime = DateTime.now().millisecondsSinceEpoch;
  }
  var diffTime = dataIsBetween ? (endTime - targetTime) : 0;
  return diffTime.toCountDown(countDown: countDown);
}
