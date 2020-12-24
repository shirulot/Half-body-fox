import 'package:flutter/material.dart';
import 'package:half_body_fox/resource/color_resource.dart';
import 'package:half_body_fox/ext/ext.dart';

enum ErrorType {
  ORDER_LIST,
  COUPONS,
  CART,
  EMPTY_PRODUCT,
  MESSAGE,
  COMMENT,
  AFTER_SALES,
  DEFAULT,
}

class FutureLoading extends StatelessWidget {
  BuildContext context;
  AsyncSnapshot snapshot;
  Function onSuccess;
  Function onError;
  ErrorType errorType;
  bool noLoading;
  Widget loading;
  Widget error;

  FutureLoading({
    Key key,
    @required this.context,
    @required this.snapshot,
    this.loading,
    this.onSuccess,
    this.error,
    this.noLoading = false,
    this.errorType,
    this.onError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => noLoading ? buildNoLoadingFuture(context, snapshot) : buildFuture(this.context, this.snapshot);

  ///加载中 暂定前几个状态都为进度条
  Widget buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.done:
        // TODO errorView
        if (snapshot.hasError) {
          this.onError?.call(snapshot.error);
          return error == null ? ErrorView(errorType: this.errorType, snapshot: snapshot) : error;
        }
        return onSuccess();
      case ConnectionState.none:
      case ConnectionState.active:
      case ConnectionState.waiting:
      default:
        return loading;
    }
  }

  ///加载中 无加载进度条/失败也不现实失败 静默加载
  Widget buildNoLoadingFuture(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.done:
        if (snapshot.hasError) return Container();
        return onSuccess();
      case ConnectionState.none:
      case ConnectionState.active:
      case ConnectionState.waiting:
      default:
        return Container();
    }
  }
}

class ErrorView extends StatelessWidget {
  ErrorType errorType;
  AsyncSnapshot snapshot;
  var e;

  ErrorView({Key key, this.errorType, this.snapshot, this.e}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 1),
              Image.asset(getPath(), width: double.infinity, height: 180.w),
              getContent().intoText(textSize: 12.w, textColor: color_gray99).intoPadding(EdgeInsets.only(top: 36.w)),
              Spacer(flex: 2),
            ],
          );
  }

  String getPath() {
    switch (errorType) {
      case ErrorType.AFTER_SALES:
      case ErrorType.ORDER_LIST:
        return "images/ic_empty_order_list.webp";
      case ErrorType.COUPONS:
        return "images/ic_empty_coupon.webp";
      case ErrorType.EMPTY_PRODUCT:
        return "images/ic_empty_cart_unlogin.webp";
      case ErrorType.MESSAGE:
        return "images/ic_empty_messages.webp";
      case ErrorType.COMMENT:
        return "images/ic_empty_reviewed.webp";
      case ErrorType.DEFAULT:
      default:
        return "images/ic_network_error.webp";
    }
//    "images/ic_network_error.webp"
  }

  String getContent() {
    switch (errorType) {
      case ErrorType.AFTER_SALES:
        return "You have no refund applications.";
      case ErrorType.ORDER_LIST:
        return "You have no purchase records.";
      case ErrorType.COUPONS:
        return "You have no coupon yet.";
      case ErrorType.EMPTY_PRODUCT:
      case ErrorType.COMMENT:
        return "It's empty.";
      case ErrorType.MESSAGE:
      case ErrorType.DEFAULT:
      default:
        return "no Message";
    }
  }
}
