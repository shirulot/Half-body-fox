import 'dart:convert';

import 'dart:typed_data';

class Base64Util {
  static String decode(String encodeString) {
    Uint8List base64deBody = base64Decode(encodeString);
    String result = Utf8Decoder().convert(base64deBody);
    return result;
  }

  static String encode(String text) {
    return base64.encode(text.codeUnits);
  }
}
