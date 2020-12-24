class CodeException implements Exception {
  int code;

  String msg;

  String serverMessage;

  CodeException({this.code, this.msg, this.serverMessage});

  @override
  String toString() {
    return '$code: $msg';
  }
}
