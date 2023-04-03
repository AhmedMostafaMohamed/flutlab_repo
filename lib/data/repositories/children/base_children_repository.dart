import '../../models/child.dart';
import '../../models/user.dart';

abstract class BaseChildrenRepository {
  Stream<List<Child>> getChildren(String parentId);
  Stream<User> getParent(String parentId);
  Future<void> addChild(Child child);
}
