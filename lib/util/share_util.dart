import 'package:half_body_fox/network/http.dart';
import 'package:half_body_fox/network/url_path_resource.dart';
import 'package:half_body_fox/util/toast_util.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:half_body_fox/ext/ext.dart';

class ShareUtil {
  static shareToWhatsApp(String text) async {
//直接对指定号码发送消息
// 参考: https://api.whatsapp.com/send?phone=$phone&text=${URLEncoder.encode(message, "UTF-8")}
//  const url = 'whatsapp://send?phone=$phone';
    String url = "https://wa.me/?text=$text";
    var encoded = Uri.encodeFull(url);

    if (await canLaunch(encoded)) {
      await launch(encoded);
    } else {
      throw 'Could not launch $url';
    }
  }

  static shareToFB(String text) async {
    String url = "fb://profile/402727317248911/?text=$text";
    var encoded = Uri.encodeFull(url);
    await launch(encoded, forceSafariVC: false, forceWebView: false);
  }

  static extShare(Map map, {String type}) async {
    // var url = await HttpUtil.requestNetwork(shareLinkCreatePath, request: map);
    // if (url is String && !url.isNullOrBlank()) {
    //   Share.share(url);
    // } else {
    //   ToastUtil.showT("Share link creation failed");
    // }
  }
}
