import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:half_body_fox/base/base_state.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:half_body_fox/widget/empty_view.dart';
import 'package:half_body_fox/ext/ext.dart';
import 'package:half_body_fox/widget/future_loading.dart';
import 'package:half_body_fox/util/logger_util.dart';

//typedef AsyncListFunction<S> = Future<List<S>> Function();

abstract class ListState<T extends StatefulWidget> extends BaseState<T> {
  int page = 0;
  List list = [];
  bool isFirst = true;
  bool showErrorPage = false;
  EasyRefreshController controller = EasyRefreshController();
  var e;
  int pageSize = 10;
  bool enableRefresh = true;
  bool enableLoadMore = true;

  loadData({int page}) async {
    try {
      this.page = page;
      List list = await loadData2Model(page);
      print("page = $page ");
      if ((!isPageMode() && this.page == 0) || (isPageMode() && this.page == 1)) this.list.clear();
      this.list.addAll(list);
      this.page = isPageMode() ? page + 1 : this.list.length;
      setState(() {
        isFirst = false;
        showErrorPage = false;
        controller.finishRefresh(success: true, noMore: false);
        controller.finishLoad(success: true, noMore: list.length < 10);
      });
    } catch (e) {
      setState(() {
        logger.e(e);
        this.e = e;
        showErrorPage = isFirst;
        controller.finishRefresh(success: false, noMore: false);
        controller.finishLoad(success: false, noMore: false);
      });
    }
  }

  Widget buildListView() {
    return EasyRefresh(
      firstRefresh: true,
      firstRefreshWidget: loadingWidget(),
      emptyWidget: buildEmptyView(),
      controller: controller,
      onRefresh: enableRefresh ? () => loadData(page: isPageMode() ? 1 : 0) : null,
      onLoad: enableLoadMore ? () => loadData(page: page) : null,
      child: showErrorPage ? ErrorView(e: e, errorType: errorType()) : listView(),
    );
  }

  emptyType() => errorType();

  Widget listView() => ListView.builder(shrinkWrap: true, itemBuilder: buildItem, itemCount: list.length, padding: EdgeInsets.zero);

  Widget buildEmptyView() => list.isNullOrEmpty() ? ErrorView(errorType: emptyType()).intoExpanded() : null;

  Widget buildFirstErrorView() => ErrorView(e: e);

  bool isPageMode() => false;

  ///存在内容 如果子组件需要重写 需要调用super
  @override
  initView() {
    page = isPageMode() ? 1 : 0;
  }

  ///返回必须是list 需在model处理完后返回
  Future<List> loadData2Model(int pageOrFromCount);

  ///重写此方法创建子布局
  Widget buildItem(BuildContext context, int index);

  @override
  Widget body(BuildContext context) => buildListView();
}
