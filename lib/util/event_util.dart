
import 'package:event_bus/event_bus.dart';
import 'package:half_body_fox/entity/event/base_event.dart';

class EventUtil {

 static EventBus eventBus;
 static init(){
   EventUtil.eventBus = EventBus();
 }
 static post<T extends BaseEvent>(T event){
   EventUtil.eventBus.fire(event);
 }

 static catchEvent<T extends BaseEvent>(Function listen){
   EventUtil.eventBus.on<T>().listen(listen);
 }
}