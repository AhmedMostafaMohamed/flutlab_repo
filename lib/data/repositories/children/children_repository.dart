import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:schoner_tag/data/models/child.dart';

import '../../models/group.dart';
import '../../models/user.dart' as myUser;
import 'base_children_repository.dart';

class ChildrenRepository extends BaseChildrenRepository {
  final FirebaseFirestore _firebaseFirestore;

  ChildrenRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
  @override
  Stream<List<Child>> getChildren(String parentId) {
    return _firebaseFirestore
        .collection('users')
        .doc(parentId)
        .collection('children')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Child.fromSnapshot(doc)).toList();
    });
  }

  @override
  Stream<myUser.User> getParent(String parentId) {
    // TODO: implement getParent
    throw UnimplementedError();
  }

  @override
  Future<void> addChild(Child child) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('children')
          .doc()
          .set({'child': child.toMap()});
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
