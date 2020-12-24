

import 'base_event.dart';

class PageFlipEvent extends BaseEvent{

  int page = 0;

  PageFlipEvent(this.page);
}