import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schoner_tag/data/models/user.dart';
import 'package:schoner_tag/data/models/group.dart';
import 'package:schoner_tag/data/models/child.dart';
import 'package:schoner_tag/data/repositories/group/base_group_repository.dart';

class GroupRepository extends BaseGroupRepository {
  final FirebaseFirestore _firebaseFirestore;

  GroupRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
  @override
  @override
  Future<void> createGroupChildren(String eventId, List<Child> children,
      String name, String location, List<User> instructors) async {
    try {
      await _firebaseFirestore
          .collection('events')
          .doc(eventId)
          .collection('groups')
          .doc(name)
          .set({'group': Group(name: name, location: location).toMap()});
    } catch (e) {
      print(e);
    }
    for (var child in children) {
      try {
        await _firebaseFirestore
            .collection('events')
            .doc(eventId)
            .collection('groups')
            .doc(name)
            .collection('subscribers')
            .doc()
            .set({'child': child.toMap()});
      } catch (e) {
        print(e);
      }
    }
    for (var instructor in instructors) {
      try {
        await _firebaseFirestore
            .collection('events')
            .doc(eventId)
            .collection('groups')
            .doc(name)
            .collection('instructors')
            .doc()
            .set({'user': instructor.toMap()});
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Stream<List<Group>> getAllGroups(String eventId) {
    return _firebaseFirestore
        .collection('events')
        .doc(eventId)
        .collection('groups')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Group.fromSnapshot(doc)).toList();
    });
  }

  @override
  Stream<List<Child>> getGroupChildren(String eventId, String groupName) {
    return _firebaseFirestore
        .collection('events')
        .doc(eventId)
        .collection('groups')
        .doc(groupName)
        .collection('subscribers')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Child.fromSnapshot(doc)).toList();
    });
  }

  @override
  Stream<List<User>> getGroupInstructors(String eventId, String groupName) {
    return _firebaseFirestore
        .collection('events')
        .doc(eventId)
        .collection('groups')
        .doc(groupName)
        .collection('instructors')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => User.fromSnapshot(doc)).toList();
    });
  }

  @override
  Future<bool> deleteGroup(String groupName, String eventId) async {
    try {
      await _firebaseFirestore
          .collection('events')
          .doc(eventId)
          .collection('groups')
          .doc(groupName)
          .delete();
      return Future(() => true);
    } catch (e) {
      return Future(() => false);
    }
  }
}
