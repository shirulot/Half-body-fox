class SizeUtil {
  static double windowWidth;
  static double ratio = 0;

  static init(double windowWidth) {
    SizeUtil.windowWidth = windowWidth;
    SizeUtil.ratio = windowWidth / 360;
  }

  static double dp(double dp) {
    return ratio == 0 ? dp : ratio * dp;
  }
}
