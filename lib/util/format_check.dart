import 'package:half_body_fox/ext/ext.dart';


  bool isEmail(String email) {
    var pattern = new RegExp("^[a-zA-Z0-9][\\w\\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\\w\\.-]*[a-zA-Z0-9]\\.[a-zA-Z][a-zA-Z\\.]*[a-zA-Z]\$");
    if (email.isNullOrBlank()) {
      return false;
    } else {
      return pattern.hasMatch(email);
    }
  }


