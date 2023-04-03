import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Group extends Equatable {
  final String name;
  final String location;
  String id;

  Group({required this.name, required this.location, this.id = '0'});
  @override
  List<Object?> get props => [name, location, id];
  static Group fromSnapshot(DocumentSnapshot snap) {
    Group group = Group(
        name: snap['group']['name'],
        location: snap['group']['location'],
        id: snap.id);
    return group;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'name': name, 'location': location};
  }
}
