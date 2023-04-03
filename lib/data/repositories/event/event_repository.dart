import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schoner_tag/data/models/child.dart';
import 'package:schoner_tag/data/models/event.dart';
import 'package:schoner_tag/data/models/group.dart';

import 'base_event_repository.dart';

class EventRepository extends BaseEventRepository {
  final FirebaseFirestore _firebaseFirestore;

  EventRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Event>> getAllEvents() {
    return _firebaseFirestore.collection('events').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Event.fromSnapshot(doc)).toList();
    });
  }

  @override
  Future<void> createEvent(Event event) {
    // TODO: implement createEvent
    throw UnimplementedError();
  }
}
