import 'base_event.dart';

class CartCountChangeEvent extends BaseEvent {
  int count = 0;

  CartCountChangeEvent(this.count);

}
