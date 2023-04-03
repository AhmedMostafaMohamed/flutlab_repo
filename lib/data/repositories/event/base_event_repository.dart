import '../../models/child.dart';
import '../../models/event.dart';
import '../../models/group.dart';

abstract class BaseEventRepository {
  Stream<List<Event>> getAllEvents();
  Future<void> createEvent(Event event);
}
