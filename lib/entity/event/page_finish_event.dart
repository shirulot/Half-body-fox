import 'base_event.dart';

class PageFinishEvent extends BaseEvent{

  List<String> routeNames ;

  PageFinishEvent(this.routeNames);
}