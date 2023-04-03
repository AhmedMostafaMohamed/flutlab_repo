import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String name;
  final String description;
  final String date;
  final String location;
  final String privacy;
  final int maxEntries;
  final String imageUrl;
  String id;

  Event(
      {required this.name,
      required this.description,
      this.id = '0',
      required this.date,
      required this.location,
      required this.privacy,
      required this.maxEntries,
      required this.imageUrl});

  @override
  List<Object?> get props => [name, description];
  static Event fromSnapshot(DocumentSnapshot snap) {
    Event event = Event(
        name: snap['event']['name'],
        description: snap['event']['description'],
        date: snap['event']['date'],
        id: snap.id,
        location: snap['event']['location'],
        privacy: snap['event']['privacy'],
        maxEntries: snap['event']['maxEntries'],
        imageUrl: snap['event']['imageUrl']);
    return event;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'date': date,
      'maxEntries': maxEntries,
      'location': location,
      'privacy': privacy,
      'imageUrl': imageUrl,
    };
  }
}
