import '../../models/child.dart';
import '../../models/group.dart';
import '../../models/user.dart';

abstract class BaseGroupRepository {
  Stream<List<Child>> getGroupChildren(String eventId, String groupName);
  Stream<List<User>> getGroupInstructors(String eventId, String groupName);
  Stream<List<Group>> getAllGroups(String eventId);
  Future<bool> deleteGroup(String groupName, String eventId);
  Future<void> createGroupChildren(String eventId, List<Child> children,
      String name, String location, List<User> instructors);
}
